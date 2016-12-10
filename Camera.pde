class Camera extends GameObject {
	boolean active = true;
	float scale;

	public Camera(Transform _transform, float _scale) {
		super(_transform);
		scale = _scale;

		applyPhysics(new PVector2D(10, 0), 10, 0);
		physics.cd = 0.7;
		// physics = new Physics();
	}

	public Camera() {
		this(new Transform(), 0);
	}

	void interact() {
		if (active) {
			if (keys[37].pressed) {
				fill(0, 255, 255);
				ellipse(width/2, height/2, 50, 50);
				physics.applyForce(new PVector2D(-10, 0), new PVector2D(0, 0));
			}
			if (keys[38].pressed) {
				fill(0, 255, 255);
				ellipse(width/2, height/2, 50, 50);
				physics.applyForce(new PVector2D(0, -10), new PVector2D(0, 0));

			}
			if (keys[39].pressed) {
				fill(0, 255, 255);
				ellipse(width/2, height/2, 50, 50);
				physics.applyForce(new PVector2D(10, 0), new PVector2D(0, 0));

			}
			if (keys[40].pressed) {
				fill(0, 255, 255);
				ellipse(width/2, height/2, 50, 50);
				physics.applyForce(new PVector2D(0, 10), new PVector2D(0, 0));

			}
		}
		
	}

	void update(Camera _camera) {
		super.update(_camera);
		interact();
	}
}