class CelestialBody extends GameObject {
	String name;
	float radius;
	float mass;
	public CelestialBody(String _name, Transform _transform, float _radius) {
		super(_transform);

		radius = _radius;

		mass = pow(radius, 3);
		applyPhysics(new PVector2D(10, 0), mass, pow(mass, 5/3), false);
		name = _name;
	}

	String getName() {
		return name + "\nmass: " + mass + "\nradius: " + radius;
	}

	void showName() {
		if (distSq(transform.position, transform.position) < width/2) {
			textAlign(CENTER);
			fill(150);
			text(getName(), 0, radius + 25);
			textAlign(LEFT);
		}
	}

	void drawBody() {
		showName();
	}
}