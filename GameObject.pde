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

	void applyPhysics(PVector2D _velocity, float _mass, float _moment) {
		physics = new Physics(transform.position, _velocity, _mass, _moment);
	}

	void registerCamera(Camera _camera) {
		camera = _camera;
	}

	// void registerScreen()

	// GamePbject with no physics


	void update() {
		if (physics != null) {
			physics.update();
		}

		inFrustum = abs(transform.position.getX() - camera.transform.position.getX()) < width/2 && abs(transform.position.getY() - camera.transform.position.getY()) < height/2;


	}
}