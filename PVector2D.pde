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

	PVector2D add(PVector2D _delta) {
		PVector v3 = this.copy();
		v3.v.add(_delta.v);

		return v3;
	}

	PVector2D sub(PVector2D _delta) {
		PVector v3 = this.copy();
		v3.v.sub(_delta.v);

		return v3;
	}

	PVector2D mult(float _factor) {
		PVector v3 = this.copy();
		v3.v.mult(_delta.v);

		return v3;
	}

	PVector2D div(float _factor) {
		PVector v3 = this.copy();
		v3.v.div(_delta.v);

		return v3;
	}

	PVector2D cross(PVector2D _v2) {
		PVector v3 = this.copy();
		v3.v.cross(_delta.v);

		return v3;
	}

	PVector2D dot(PVector2D _v2) {
		PVector v3 = this.copy();
		v3.v.dot(_delta.v);

		return v3;
	}

	float mag() {
		return v.mag();
	}

	// returns the normalized copy
	PVector2D normalized() {
		PVector2D v2 new PVector2D(v);
		v2.normalize();

		return v2;
	}

	float angleBetween(PVector2D _v2) {
		return atan2(y - v2.v.y, x - v2.v.x) + PI;
	}
}