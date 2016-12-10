class Key {
	int code;

	boolean pressed = false;
	boolean released = false;
	boolean clicked = false;
	int pressedTimer = 0;
	int releasedTimer = 0;

	public Key(int code) {
		this.code = code;
	}

	void update() {
		pressedTimer += 1;
		clicked = false;

		releasedTimer += 1;
		released = false;
	}
}

int MAX_KEYS = 200;

Key[] keys = new Key[MAX_KEYS];

// ArrayList<Key> pressedKeys = new ArrayList<Key>();
ArrayList<Integer> pressedKeys = new ArrayList<Integer>();

void keyPressed() {
	boolean inArr = false;

	if (keyCode < MAX_KEYS) {

		keys[keyCode].pressed = true;
		keys[keyCode].released = false;
		keys[keyCode].clicked = true;

		for (int i = 0; i < pressedKeys.size(); i++) {
			if (pressedKeys.get(i).intValue() == keyCode) {
				inArr = true;
			}
		}

		if (!inArr) {
			pressedKeys.add(new Integer(keyCode));
		}
	}
}

void keyReleased() {
	if (keyCode < MAX_KEYS) {

		keys[keyCode].pressed = false;
		keys[keyCode].released = true;
		keys[keyCode].clicked = false;
		keys[keyCode].releasedTimer = 0;

		int i = 0;
		boolean found = false;

		while (!found && i < pressedKeys.size()) {
			if (pressedKeys.get(i).intValue() == keyCode) {
				found = true;
				pressedKeys.remove(i);

				i -= 1;
			}

			i += 1;
		}
	}
}

void updateKey(int i) {
	if (keys[i].pressed) {
		keys[i].pressedTimer += 1;
	} else {
		keys[i].pressedTimer = 0;
	}

	if (keys[i].pressedTimer == 1) {
		keys[i].clicked = true;
	} else {
		keys[i].clicked = false;
	}

	if (!keys[i].pressed) {
		keys[i].releasedTimer += 1;
	}

	if (keys[i].releasedTimer == 1) {
		keys[i].released = true;
	} else {
		keys[i].released = false;
	}
}

void updateKeys() {
	for (int i = 16; i < 100; i++) {
		updateKey(i);
	}

	//// update the = key
	updateKey(187);
}

class Coords {
	int x;
	int y;

	public Coords(int x, int y) {
		this.x = x;
		this.y = y;
	}
}

int gSizeX = 3000;
int gSizeY = 3000;

float posX = gSizeX / 2;
float posY = gSizeY / 2 - 300;

//////////// mouse

public class Mouse {
	int prevX = mouseX;
	int prevY = mouseY;
	int x = mouseX;
	int y = mouseY;

	boolean isPressed = false;
	boolean isReleased = false;
	boolean isDragged = false;
	int pressedTimer = 0;
	int releasedTimer = 0;
	boolean clicked = false;
	boolean released = false;

	int dx = 0;
	int dy = 0;

	// selecting when mouse.selecting && mouse.clickNum == 0

	boolean selecting = false;
	boolean select = false;
	int clickNum = 0;
	Coords click1 = new Coords(x, y);
	Coords click2 = new Coords(x, y);

	public Mouse() {

	}

	void addPressed() {
		pressedTimer += 1;
	}

	void addReleased() {
		releasedTimer += 1;
	}

	void update() {

		if (pressedTimer == 1) {
			clicked = true;
		} else {
			clicked = false;
		}

		if (releasedTimer == 1) {
			released = true;
		} else {
			released = false;
		}
	}

	void check() {
		prevX = x;
		prevY = y;

		x = mouseX;
		y = mouseY;

		dx = mouseX - prevX;
		dy = mouseY - prevY;

		if (isPressed) {
			pressedTimer += 1;
		} else {
			pressedTimer = 0;
		}

		if (pressedTimer == 1) {
			clicked = true;
		} else {
			clicked = false;
		}

		if (isReleased) {
			releasedTimer += 1;
		} else {
			releasedTimer = 0;
		}

		if (releasedTimer == 1) {
			released = true;
		} else {
			released = false;
		}

		if (clickNum == 0) {
			selecting = false;
		}

		// selecting - hold shift
		if (keys[16].pressed) {
			if (released) {
				clickNum += 1;

				if (clickNum == 1) {
					selecting = true;
					click1.x = x + (int) round(posX);
					click1.y = y + (int) round(posY);
				}

				if (clickNum == 2) {
					selecting = true;
					click2.x = x + (int) round(posX);
					click2.y = y + (int) round(posY);
				}

			} // if released
		} else {
			// shift is not held
			if (clicked) {
				clickNum = 0;
				selecting = false;
			}
		}

		// 0 - nothing selected; 1 - 1st point selected; 2 - 2nd point
		// selected --> immediately back to 0
		if (clickNum > 1) {
			clickNum = 0;
		}

		select = selecting && clickNum == 0;

	}

	void draw() {
		stroke(0, 255, 0);
		line(x - 20, y - 20, x + 20, y + 20);
		line(x + 20, y - 20, x - 20, y + 20);

		if (clickNum == 1) {
			pushMatrix();
			translate(-posX, -posY);
			fill(255, 255, 255, 100);
			stroke(255, 255, 255);
			rect(click1.x, click1.y, (x + posX) - click1.x, (y + posY) - click1.y);
			noStroke();
			popMatrix();
		}
	}
}

Mouse mouse = new Mouse();

void mousePressed() {
	mouse.isPressed = true;
	mouse.isReleased = false;
}

void mouseDragged() {
	mouse.isDragged = true;
}

void mouseReleased() {
	mouse.isPressed = false;
	mouse.isDragged = false;
	mouse.isReleased = true;
}

///////////////////////////////////////
float distSq(PVector p1, PVector p2) {
	return (pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
}

float distSq(PVector2D p1, PVector2D p2) {
	return (pow(p1.v.x - p2.v.x, 2) + pow(p1.v.y - p2.v.y, 2));
}

float distSq(float x, float y) {
	return (pow(x, 2) + pow(y, 2));
}