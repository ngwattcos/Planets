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

	void interact() {
		if (keys[38].pressed) {

		}
	}

	void update() {
		interact();
	}
}