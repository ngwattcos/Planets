class Transform {
	Physics physics;
	PVector2D position;
	float rotation;

	GameObject body;

	public Transform() {
		this(new PVector2D(0, 0), 0);
	}

	public Transform(PVector2D _position) {
		this(_position, 0.0);
	}

	public Transform(PVector2D _position, float _rotation) {
		// does NOT store a copy, but a direct reference
		position = _position;
		rotation = _rotation;
	}

	void setPosition(PVector2D _position) {
		position = _position;
	}

	void setRotation(float _rotation) {
		rotation = _rotation;
	}

	void move(Transform _delta) {

	}

	void setBody(GameObject o) {
		body = o;
	}

	float getRotation() {
		return rotation;
	}

}