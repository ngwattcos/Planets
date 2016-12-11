class Planet extends CelestialBody {
	Color col;
	float orbitRadius;
	float orbitAngle;
	float w;

	
	public Planet(String _name, float _radius, Color _col, Star star, float _orbitRadius) {
		super(_name, new Transform(), _radius);
		star.attach(this);

		orbitAngle = random(0, 1) * PI * 2;
		orbitRadius = _orbitRadius;
		w = pow(star.physics.mass, 0.5) / pow(orbitRadius, 1.5)/100;
		col = _col;
	}
	String getName() {
		return super.getName() + "\n" + orbitAngle;
	}

	void drawBody() {
		super.drawBody();
		noStroke();
		fill(col.r, col.g, col.b);
		ellipse(0, 0, radius * 2, radius * 2);
	}

	void update() {
		transform.position.v.x = parent.transform.position.getX() + cos(orbitAngle) * orbitRadius;
		transform.position.v.y = parent.transform.position.getY() + sin(orbitAngle) * orbitRadius;

		orbitAngle += w;
	}

	void drawConnections() {
		stroke(0, 255, 0);
		strokeWeight(1);
		line(transform.position.getX() - cos(orbitAngle) * radius, transform.position.getY() - sin(orbitAngle) * radius, parent.transform.position.getX() + cos(orbitAngle) * ((Star) parent).radius, parent.transform.position.getY() + sin(orbitAngle) * ((Star) parent).radius);
		noStroke();
	}
}