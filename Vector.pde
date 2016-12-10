class Vector {

	// static Vector ZERO = new Vector(0.0, 0.0);

	float x;
	float y;
	float angle;
	float mag;

	// default zero vector
	public Vector() {
		this(0.0, 0.0);
	}

	// create a Vector with components
	public Vector(float _x, float _y) {
		x = _x;
		y = _y;

		syncProperties();
	}

	// create a Vector based on angle and magnitude
	public Vector(float _angle, float _mag, String s) {
		angle = _angle;
		mag = _mag;

		syncComponents();
	}

	void reset() {
		x = 0;
		y = 0;
		syncProperties();
	}

	void setX(float _x) {

		x = _x;

		// change angle, mag
		syncProperties();
	}

	void setY(float _y) {

		y = _y;

		// change angle, mag
		syncProperties();
	}

	void setAngle(float _angle) {

		angle = _angle;

		// change x, y
		syncComponents();
	}

	void setMag(float _mag) {

		mag = _mag;

		// change mag
		syncComponents();
	}

	void syncComponents() {
		x = cos(angle) * mag;
		y = sin(angle) * mag;
	}

	void syncProperties() {
		angle = atan2(y, x);
		mag = sqrt(pow(x, 2) + pow(y, 2));
	}

	float angleBetween(Vector v2) {
		return atan2(y - v2.y, x - v2.x) + PI;
	}

	Vector copy() {
		Vector c = new Vector(x, y);

		return c;
	}

	Vector add(Vector v2) {

		float _x = x + v2.x;
		float _y = y + v2.y;

		return new Vector(_x, _y);
	}

	Vector subtract(Vector v2) {

		float _x = x - v2.x;
		float _y = y - v2.y;

		return new Vector(_x, _y);
	}

	/*
	 * Vector cross(Vector v2) {
	 * 
	 * float theta = angle = v2.angle;
	 * 
	 * 
	 * return new Vector(); }
	 */

	float cross(Vector v2) {
		// float theta = angle - v2.angle;

		float theta = angleBetween(v2);

		theta = theta - PI;

		return mag * v2.mag * sin(theta);
	}



	Vector mult(float a) {
		return new Vector(angle, mag * a, "");
	}

	Vector divide(float a) {
		return new Vector(angle, mag / a, "");
	}

	void draw(Vector p) {
		pushMatrix();
		translate(p.x, p.y);
		stroke(0, 255, 0);
		line(0, 0, mag * cos(angle), mag * sin(angle));
		popMatrix();
	}

}