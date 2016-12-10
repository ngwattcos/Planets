import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Planets extends PApplet {

public void setup() {
	
	for (int i = 0; i < keys.length; i++) {
		keys[i] = new Key(i);
	}
}

Camera camera;

public void load() {
	camera = new Camera();


}

int frameCounter = 0;

public void draw() {
	background(0);

	if (frameCounter == 0) {
		load();
	}

	updateKeys();

	mouse.check();

	camera.update();

	mouse.draw();
}
class Body {
	
}
class Camera extends GameObject {
	
	float scale;

	public Camera(Transform _transform, float _scale) {
		super(_transform);
		scale = _scale;

		physics = new Physics(transform.position, new PVector2D(0, 0), 10, 0);
		// physics = new Physics();
	}

	public Camera() {
		this(new Transform(), 0);
	}

	public void interact() {
		if (keys[38].pressed) {

		}
	}

	public void update() {
		interact();
	}
}
class GameObject extends Node {

	Transform transform;
	Physics physics;
	boolean inFrustum = true;
	Camera camera;

	// a reference to physics.position
	PVector position;

	// GameObject with physics
	public GameObject(Transform _transform) {
		transform = _transform;
		transform.setBody(this);

		// this reference stays forever
		// transform.position = physics.position;
	}

	public void applyPhysics(PVector2D _velocity, float _mass, float _moment) {
		physics = new Physics(transform.position, _velocity, _mass, _moment);
	}

	public void registerCamera(Camera _camera) {
		camera = _camera;
	}

	// void registerScreen()

	// GamePbject with no physics


	public void update() {
		if (physics != null) {
			physics.update();
		}

		inFrustum = abs(transform.position.getX() - camera.transform.position.getX()) < width/2 && abs(transform.position.getY() - camera.transform.position.getY()) < height/2;


	}
}
class Node {
	Node parent;

	ArrayList<Node> children;

	public Node() {
		
	}
}
// wrapper class for PVector to give extended functionality

class PVector2D {
	PVector v;

	public PVector2D(float x, float y) {
		v = new PVector(x, y);
	}

	public PVector2D(PVector2D _vec) {
		v = _vec.v.copy();
	}

	public PVector2D(PVector _v) {
		v = _v;
	}

	public void set(PVector _v2) {
		v = _v2;
	}

	public void set(float x, float y) {
		v.x = x;
		v.y = y;
	}

	// create new copy
	public PVector2D copy() {
		return new PVector2D(v.copy());
	}

	public void reset() {
		v.x = 0;
		v.y = 0;
	}

	public PVector2D add(PVector2D _delta) {
		PVector2D v3 = this.copy();
		v3.v.add(_delta.v);

		return v3;
	}

	public PVector2D sub(PVector2D _delta) {
		PVector2D v3 = this.copy();
		v3.v.sub(_delta.v);

		return v3;
	}

	public PVector2D mult(float _factor) {
		PVector2D v3 = this.copy();
		v3.v.mult(_factor);

		return v3;
	}

	public PVector2D div(float _factor) {
		PVector2D v3 = this.copy();
		v3.v.div(_factor);

		return v3;
	}

	public PVector2D cross(PVector2D _v2) {
		PVector2D v3 = this.copy();
		v3.v.cross(_v2.v);

		return v3;
	}

	public PVector2D dot(PVector2D _v2) {
		PVector2D v3 = this.copy();
		v3.v.dot(_v2.v);

		return v3;
	}

	public float mag() {
		return v.mag();
	}

	// returns the normalized copy
	public PVector2D normalized() {
		PVector2D v2 = this.copy();
		v2.v.normalize();

		return v2;
	}

	public float angleBetween(PVector2D v2) {
		return atan2(v.y - v2.v.y, v.x - v2.v.x) + PI;
	}

	public float getX() {
		return v.x;
	}

	public float getY() {
		return v.y;
	}
}
// ficional constant in a fictional universe
float G = 0.001f;

class Physics {

	float mass;
	float moment;
	PVector2D center; // it is assumed center is the center of mass
	PVector2D velocity;
	PVector2D acceleration;
	PVector2D position;
	PVector2D prev;


	PVector2D forces;
	float torques; // is used to represent torque

	float angle;
	float omega;
	float alpha;

	float cd = 0;	// coefficient of drag

	String typeObj;

	public Physics() {
		this(new PVector2D(0, 0), new PVector2D(0, 0), 0, 0);
	}

	public Physics(PVector2D _position, PVector2D _velocity, float _mass, float _moment) {
		position = _position;
		velocity = _velocity.copy();
		forces = new PVector2D(0, 0);
		acceleration = forces.div(mass);

		mass = _mass;
		moment = _moment;

	}

	public void applyForce(PVector2D force, PVector2D pos) {
		// can also apply a torque

		forces = forces.add(force);

		// torque = r x F
		if (abs(force.cross(pos).mag()) > 0.0001f) {

			// torques

			// direction to point of application
			float theta;
			float r;
			float t1;

			theta = position.angleBetween(pos);
			r = sqrt(distSq(position, pos));
			// T = r * F * sin(\u00f8)

			// + is counterclockwise, - is clockwise
			t1 = r * force.mag() * sin(theta) / 10.0f;

			// torques += t1;
		}
	}

	public void applyGravity(Physics o) {

		// angle from the object
		float theta = position.angleBetween(o.position);

		// magnitude of the force
		float fg = G * mass * o.mass / distSq(position, o.position);

		// combine into a PVector2D
		PVector2D force_gravity = new PVector2D(theta, fg);

		// add this to the net force
		applyForce(force_gravity, new PVector2D(0, 0));

		println(fg);
	}

	public void interact() {

	}

	public void clearForces() {
		forces.reset();

		torques = 0;
	}

	public void update() {

		prev = position.copy();

		interact();

		// drag force
		forces = forces.add(new PVector2D(velocity.copy().normalized().mult(pow(velocity.mag() * cd, 2))));

		acceleration = forces.div(mass);

		velocity = velocity.add(acceleration);

		position = position.add(velocity);

		alpha = torques / moment;

		omega += alpha;

		angle += omega;

		// if position is too far left, move to right edge
		/*if (position.v.x < -boundsX) {
			position.v.x = boundsX;
		}

		// and vice versa
		if (position.v.x > boundsX) {
			position.v.x = -boundsX;
		}

		// is position is too far up, move to bottome edge
		if (position.v.y < -boundsY) {
			position.v.y = boundsY;
		}

		// and vice versa
		if (position.v.y > boundsY) {
			position.v.y = -boundsY;
		}*/
		clearForces();
	}

	public void drawForces() {
		// forces.draw(position);
	}

	public void drawObj() {

	}

	public void draw() {

		// drawForces();

		
	}
}
class System {
	
}
class Transform {
	Physics physics;
	PVector2D position;
	float rotation;

	GameObject body;

	public Transform() {
		this(new PVector2D(0, 0), 0);
	}

	public Transform(PVector2D _position) {
		this(_position, 0.0f);
	}

	public Transform(PVector2D _position, float _rotation) {
		// does NOT store a copy, but a direct reference
		position = _position;
		rotation = _rotation;
	}

	public void setPosition(PVector2D _position) {
		position = _position;
	}

	public void setRotation(float _rotation) {
		rotation = _rotation;
	}

	public void move(Transform _delta) {

	}

	public void setBody(GameObject o) {
		body = o;
	}

}
class Universe {
	ArrayList<System> systems;

	PVector2D size;

	public Universe(PVector2D _size) {
		size = _size;
	}
}
class Key {
	int code;

	boolean pressed = false;
	boolean released = false;
	boolean clicked = false;
	int pressedTimer = 0;
	int releasedTimer = 0;

	public Key(int code) {
		this.code = code;
	}

	public void update() {
		pressedTimer += 1;
		clicked = false;

		releasedTimer += 1;
		released = false;
	}
}

int MAX_KEYS = 200;

Key[] keys = new Key[MAX_KEYS];

// ArrayList<Key> pressedKeys = new ArrayList<Key>();
ArrayList<Integer> pressedKeys = new ArrayList<Integer>();

public void keyPressed() {
	boolean inArr = false;

	if (keyCode < MAX_KEYS) {

		keys[keyCode].pressed = true;
		keys[keyCode].released = false;
		keys[keyCode].clicked = true;

		for (int i = 0; i < pressedKeys.size(); i++) {
			if (pressedKeys.get(i).intValue() == keyCode) {
				inArr = true;
			}
		}

		if (!inArr) {
			pressedKeys.add(new Integer(keyCode));
		}
	}
}

public void keyReleased() {
	if (keyCode < MAX_KEYS) {

		keys[keyCode].pressed = false;
		keys[keyCode].released = true;
		keys[keyCode].clicked = false;
		keys[keyCode].releasedTimer = 0;

		int i = 0;
		boolean found = false;

		while (!found && i < pressedKeys.size()) {
			if (pressedKeys.get(i).intValue() == keyCode) {
				found = true;
				pressedKeys.remove(i);

				i -= 1;
			}

			i += 1;
		}
	}
}

public void updateKey(int i) {
	if (keys[i].pressed) {
		keys[i].pressedTimer += 1;
	} else {
		keys[i].pressedTimer = 0;
	}

	if (keys[i].pressedTimer == 1) {
		keys[i].clicked = true;
	} else {
		keys[i].clicked = false;
	}

	if (!keys[i].pressed) {
		keys[i].releasedTimer += 1;
	}

	if (keys[i].releasedTimer == 1) {
		keys[i].released = true;
	} else {
		keys[i].released = false;
	}
}

public void updateKeys() {
	for (int i = 16; i < 100; i++) {
		updateKey(i);
	}

	//// update the = key
	updateKey(187);
}

class Coords {
	int x;
	int y;

	public Coords(int x, int y) {
		this.x = x;
		this.y = y;
	}
}

int gSizeX = 3000;
int gSizeY = 3000;

float posX = gSizeX / 2;
float posY = gSizeY / 2 - 300;

//////////// mouse

public class Mouse {
	int prevX = mouseX;
	int prevY = mouseY;
	int x = mouseX;
	int y = mouseY;

	boolean isPressed = false;
	boolean isReleased = false;
	boolean isDragged = false;
	int pressedTimer = 0;
	int releasedTimer = 0;
	boolean clicked = false;
	boolean released = false;

	int dx = 0;
	int dy = 0;

	// selecting when mouse.selecting && mouse.clickNum == 0

	boolean selecting = false;
	boolean select = false;
	int clickNum = 0;
	Coords click1 = new Coords(x, y);
	Coords click2 = new Coords(x, y);

	public Mouse() {

	}

	public void addPressed() {
		pressedTimer += 1;
	}

	public void addReleased() {
		releasedTimer += 1;
	}

	public void update() {

		if (pressedTimer == 1) {
			clicked = true;
		} else {
			clicked = false;
		}

		if (releasedTimer == 1) {
			released = true;
		} else {
			released = false;
		}
	}

	public void check() {
		prevX = x;
		prevY = y;

		x = mouseX;
		y = mouseY;

		dx = mouseX - prevX;
		dy = mouseY - prevY;

		if (isPressed) {
			pressedTimer += 1;
		} else {
			pressedTimer = 0;
		}

		if (pressedTimer == 1) {
			clicked = true;
		} else {
			clicked = false;
		}

		if (isReleased) {
			releasedTimer += 1;
		} else {
			releasedTimer = 0;
		}

		if (releasedTimer == 1) {
			released = true;
		} else {
			released = false;
		}

		if (clickNum == 0) {
			selecting = false;
		}

		// selecting - hold shift
		if (keys[16].pressed) {
			if (released) {
				clickNum += 1;

				if (clickNum == 1) {
					selecting = true;
					click1.x = x + (int) round(posX);
					click1.y = y + (int) round(posY);
				}

				if (clickNum == 2) {
					selecting = true;
					click2.x = x + (int) round(posX);
					click2.y = y + (int) round(posY);
				}

			} // if released
		} else {
			// shift is not held
			if (clicked) {
				clickNum = 0;
				selecting = false;
			}
		}

		// 0 - nothing selected; 1 - 1st point selected; 2 - 2nd point
		// selected --> immediately back to 0
		if (clickNum > 1) {
			clickNum = 0;
		}

		select = selecting && clickNum == 0;

	}

	public void draw() {
		stroke(0, 255, 0);
		line(x - 20, y - 20, x + 20, y + 20);
		line(x + 20, y - 20, x - 20, y + 20);

		if (clickNum == 1) {
			pushMatrix();
			translate(-posX, -posY);
			fill(255, 255, 255, 100);
			stroke(255, 255, 255);
			rect(click1.x, click1.y, (x + posX) - click1.x, (y + posY) - click1.y);
			noStroke();
			popMatrix();
		}
	}
}

Mouse mouse = new Mouse();

public void mousePressed() {
	mouse.isPressed = true;
	mouse.isReleased = false;
}

public void mouseDragged() {
	mouse.isDragged = true;
}

public void mouseReleased() {
	mouse.isPressed = false;
	mouse.isDragged = false;
	mouse.isReleased = true;
}

///////////////////////////////////////
public float distSq(PVector p1, PVector p2) {
	return (pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
}

public float distSq(PVector2D p1, PVector2D p2) {
	return (pow(p1.v.x - p2.v.x, 2) + pow(p1.v.y - p2.v.y, 2));
}

public float distSq(float x, float y) {
	return (pow(x, 2) + pow(y, 2));
}
class Vector {

	// static Vector ZERO = new Vector(0.0, 0.0);

	float x;
	float y;
	float angle;
	float mag;

	// default zero vector
	public Vector() {
		this(0.0f, 0.0f);
	}

	// create a Vector with components
	public Vector(float _x, float _y) {
		x = _x;
		y = _y;

		syncProperties();
	}

	// create a Vector based on angle and magnitude
	public Vector(float _angle, float _mag, String s) {
		angle = _angle;
		mag = _mag;

		syncComponents();
	}

	public void reset() {
		x = 0;
		y = 0;
		syncProperties();
	}

	public void setX(float _x) {

		x = _x;

		// change angle, mag
		syncProperties();
	}

	public void setY(float _y) {

		y = _y;

		// change angle, mag
		syncProperties();
	}

	public void setAngle(float _angle) {

		angle = _angle;

		// change x, y
		syncComponents();
	}

	public void setMag(float _mag) {

		mag = _mag;

		// change mag
		syncComponents();
	}

	public void syncComponents() {
		x = cos(angle) * mag;
		y = sin(angle) * mag;
	}

	public void syncProperties() {
		angle = atan2(y, x);
		mag = sqrt(pow(x, 2) + pow(y, 2));
	}

	public float angleBetween(Vector v2) {
		return atan2(y - v2.y, x - v2.x) + PI;
	}

	public Vector copy() {
		Vector c = new Vector(x, y);

		return c;
	}

	public Vector add(Vector v2) {

		float _x = x + v2.x;
		float _y = y + v2.y;

		return new Vector(_x, _y);
	}

	public Vector subtract(Vector v2) {

		float _x = x - v2.x;
		float _y = y - v2.y;

		return new Vector(_x, _y);
	}

	/*
	 * Vector cross(Vector v2) {
	 * 
	 * float theta = angle = v2.angle;
	 * 
	 * 
	 * return new Vector(); }
	 */

	public float cross(Vector v2) {
		// float theta = angle - v2.angle;

		float theta = angleBetween(v2);

		theta = theta - PI;

		return mag * v2.mag * sin(theta);
	}



	public Vector mult(float a) {
		return new Vector(angle, mag * a, "");
	}

	public Vector divide(float a) {
		return new Vector(angle, mag / a, "");
	}

	public void draw(Vector p) {
		pushMatrix();
		translate(p.x, p.y);
		stroke(0, 255, 0);
		line(0, 0, mag * cos(angle), mag * sin(angle));
		popMatrix();
	}

}
    public void settings() { 	size(900, 600); }
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "Planets" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
