class GameObject {

	Transform transform;
	Physics physics;

	// a reference to physics.position
	PVector position;

	public GameObject(Transform _transform) {
		transform = _transform;
	}
}