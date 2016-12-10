// wrapper class for PVector to give extended functionality

class PVector2D {
	PVector v;

	public PVector2D(float x, float y) {
		v = new PVector(x, y);
	}

	public PVector2D(PVector2D _vec) {
		v = _vec.v.copy();
	}

	public PVector2D(PVector _v) {
		v = _v;
	}

	void set(PVector _v2) {
		v = _v2;
	}

	void set(float x, float y) {
		v.x = x;
		v.y = y;
	}

	// create new copy
	PVector2D copy() {
		return new PVector2D(v.copy());
	}

	void reset() {
		v.x = 0;
		v.y = 0;
	}

	PVector2D add(PVector2D _delta, String s) {
		PVector2D v3 = this.copy();
		v3.v.add(_delta.v);

		return v3;
	}

	PVector2D sub(PVector2D _delta, String s) {
		PVector2D v3 = this.copy();
		v3.v.sub(_delta.v);

		return v3;
	}

	PVector2D mult(float _factor, String s) {
		PVector2D v3 = this.copy();
		v3.v.mult(_factor);

		return v3;
	}

	PVector2D div(float _factor, String s) {
		PVector2D v3 = this.copy();
		v3.v.div(_factor);

		return v3;
	}

	PVector2D cross(PVector2D _v2, String s) {
		PVector2D v3 = this.copy();
		v3.v.cross(_v2.v);

		return v3;
	}

	PVector2D dot(PVector2D _v2, String s) {
		PVector2D v3 = this.copy();
		v3.v.dot(_v2.v);

		return v3;
	}
	////////////////////////////
	void add(PVector2D _delta) {
		v.add(_delta.v);
	}

	void sub(PVector2D _delta) {
		v.sub(_delta.v);
	}

	void mult(float _factor) {
		v.mult(_factor);
	}

	void div(float _factor) {
		v.div(_factor);
	}

	void cross(PVector2D _v2) {
		v.cross(_v2.v);
	}

	void dot(PVector2D _v2) {
		v.dot(_v2.v);
	}
	////////////////////////////

	float mag() {
		return v.mag();
	}

	// returns the normalized copy
	PVector2D normalized() {
		PVector2D v2 = this.copy();
		v2.v.normalize();

		return v2;
	}

	float angleBetween(PVector2D v2) {
		return atan2(v.y - v2.v.y, v.x - v2.v.x) + PI;
	}

	float getX() {
		return v.x;
	}

	float getY() {
		return v.y;
	}

	public String toString() {
		return v.x + ", " + v.y;
	}
}