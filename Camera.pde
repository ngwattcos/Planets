class Camera extends GameObject {
	boolean active = true;
	float scale;

	public Camera(Transform _transform, float _scale) {
		super(_transform);
		scale = _scale;

		applyPhysics(new PVector2D(10, 0), 10, 0, true);
		physics.cd = 2;
		// physics = new Physics();
	}

	public Camera() {
		this(new Transform(), 0);
	}

	void interact() {
		if (active) {
			if (keys[37].pressed) {
				physics.applyForce(new PVector2D(-50, 0), new PVector2D(0, 0));
			}
			if (keys[38].pressed) {
				physics.applyForce(new PVector2D(0, -50), new PVector2D(0, 0));

			}
			if (keys[39].pressed) {
				physics.applyForce(new PVector2D(50, 0), new PVector2D(0, 0));

			}
			if (keys[40].pressed) {
				physics.applyForce(new PVector2D(0, 50), new PVector2D(0, 0));

			}
		}
		
	}

	void update() {
		interact();
		physics.update();
	}
}