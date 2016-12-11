class Star extends CelestialBody {
	Color col;

	ArrayList<Planet> planets;
	public Star(String _name, Transform _transform, float _radius, Color _col) {
		super(_name, _transform, _radius);
		col = _col;
		println(radius);
	}



	void drawBody() {
		super.drawBody();
		noStroke();
		fill(col.r, col.g, col.b);
		ellipse(0, 0, radius * 2, radius * 2);
	}
}