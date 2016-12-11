// ficional constant in a fictional universe
float G = 0.001;

class Physics {
	boolean hasPhysics;

	float threshold = 0.02;

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
		this(new PVector2D(0, 0), new PVector2D(0, 0), 0, 0, true);
	}

	public Physics(PVector2D _position, PVector2D _velocity, float _mass, float _moment, boolean _hasPhysics) {
		hasPhysics = _hasPhysics;
		position = _position;
		velocity = _velocity.copy();
		forces = new PVector2D(0, 0);
		acceleration = forces.copy();
		acceleration.div(mass);

		mass = _mass;
		moment = _moment;

	}

	void applyForce(PVector2D force, PVector2D pos) {
		// can also apply a torque
		forces.add(force);

		// torque = r x F
		if (abs(force.copy().cross(pos, "reference").mag()) > 0.0001) {

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

	void cullMovement() {
		if (velocity.mag() < threshold && forces.mag() < threshold) {
			velocity.reset();
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

		// println(fg);
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

		cullMovement();

		// drag force
		PVector2D forceDrag = velocity.copy().normalized();
		// float fac = pow(velocity.mag(), 2) * cd;
		float fac = velocity.mag() * cd;
		forceDrag.mult(-1 * fac);
		forces.add(forceDrag);

		acceleration = forces.copy();
		acceleration.div(mass);
		if (frameCount > 15) {
			acceleration.mult(30/frameRate);
		}
		

		velocity.add(acceleration);
		if (frameCount > 15) {
			velocity.mult(30/frameRate);
		}
		

		position.add(velocity);

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

	void drawForces() {
		// forces.draw(position);
	}

	void drawObj() {

	}

	void draw() {

		// drawForces();

		
	}
}