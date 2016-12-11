class GameObject extends Node {

	Transform transform;
	Physics physics;
	boolean inFrustum = true;
	boolean selected = false;

	GameObject parent;

	int selectSize;

	ArrayList<GameObject> children;

	// a reference to physics.position
	PVector position;

	// GameObject with physics
	public GameObject(Transform _transform) {
		transform = _transform;
		transform.setBody(this);

		// this reference stays forever
		// transform.position = physics.position;
		children = new ArrayList<GameObject>();
	}

	void attach(GameObject o) {
		children.add(o);
		o.setParent(this);

	}

	// severs connection with previous parent, gets new parent
	void setParent(GameObject p) {
		detach();
		this.parent = p;
	}

	void destroy() {
		// if deleted...
		// all children have no parent
		for (GameObject child: children) {
			child.setParent(null);
		}

		//  parent no longer has reference to this
		parent.children.remove(this);
	}

	void detach() {
		if (parent != null) {
			// leave parent
			parent = null;
			// parent's connection to child is severed
			parent.children.remove(this);
		}
	}

	void applyPhysics(PVector2D _velocity, float _mass, float _moment, boolean _hasPhysics) {
		physics = new Physics(transform.position, _velocity, _mass, _moment, _hasPhysics);
	}

	void registerCamera(Camera _camera) {
		camera = _camera;
	}

	// void registerScreen()

	// GamePbject with no physics

	void interact() {

	}

	void update() {
		interact();

		if (physics != null && physics.hasPhysics) {
			physics.update();
		}

		inFrustum = abs(transform.position.getX() - camera.transform.position.getX() - width/2) < width && abs(transform.position.getY() - camera.transform.position.getY() - height/2) < height;


	}

	void drawConnections() {

	}

	void drawBody() {

	}

	void draw() {
		drawConnections();
		
		pushMatrix();
			translate(transform.position.getX(), transform.position.getY());
			rotate(transform.getRotation());
			if (inFrustum) {
				drawBody();
			}
		popMatrix();


		
	}
}