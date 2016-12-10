class Transform {
	PVector position;
	float rotation;

	public Transform() {
		this(new PVector(0, 0), 0);
	}

	public Transform(PVector _position) {
		this(_position, 0.0);
	}

	public Transform(PVector _position, float _rotation) {
		// does NOT store a copy, but a direct reference
		position = _position;
		roation = _rotation;
	}

}