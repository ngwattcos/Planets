// ficional constant in a fictional universe
float G = 0.001;

abstract class Physics {

	int mass;
	int moment;
	PVector2D center; // it is assumed center is the center of mass
	PVector2D velocity;
	PVector2D acceleration;
	PVector2D position;
	PVector2D prev;

	boolean inFrustum = true;

	PVector2D forces;
	float torques; // is used to represent torque

	float angle;
	float omega;
	float alpha;

	String typeObj;

	public Physics(PVector2D _position, PVector2D _velocity, int _mass, int _moment) {
		position = _position;
		velocity = _velocity.copy();
		forces = new PVector2D(0, 0);
		acceleration = forces.divide(mass);

		mass = _mass;
		moment = _moment;

	}

	void applyForce(PVector2D force, PVector2D pos) {
		// can also apply a torque

		forces = forces.add(force);

		// torque = r x F
		if (abs(force.cross(pos)) > 0.0001) {

			// torques

			// direction to point of application
			float theta;
			float r;
			float t1;

			theta = position.angleBetween(pos);
			r = sqrt(distSq(position, pos));
			// T = r * F * sin(ø)

			// + is counterclockwise, - is clockwise
			t1 = r * force.mag() * sin(theta) / 10.0;

			// torques += t1;
		}
	}

	void applyGravity(Physics o) {

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

	void interact() {

	}

	void clearForces() {
		forces.reset();

		torques = 0;
	}

	void update() {

		prev = position.copy();

		interact();

		acceleration = forces.divide(mass);

		velocity = velocity.add(acceleration);

		position = position.add(velocity);

		alpha = torques / moment;

		omega += alpha;

		angle += omega;

		// if position is too far left, move to right edge
		if (position.x < -boundsX) {
			position.x = boundsX;
		}

		// and vice versa
		if (position.x > boundsX) {
			position.x = -boundsX;
		}

		// is position is too far up, move to bottome edge
		if (position.y < -boundsY) {
			position.y = boundsY;
		}

		// and vice versa
		if (position.y > boundsY) {
			position.y = -boundsY;
		}
	}

	void drawForces() {
		// forces.draw(position);
	}

	void drawObj() {

	}

	void draw() {

		if (inFrustum) {
			drawObj();
		}

		// drawForces();

		clearForces();
	}
}