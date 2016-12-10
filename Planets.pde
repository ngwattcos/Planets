PFont monaco;
PFont courierNew;


void setup() {
	size(900, 600, OPENGL);

	monaco = createFont("monaco", 20);
	courierNew = createFont("monaco", 10);

	for (int i = 0; i < keys.length; i++) {
		keys[i] = new Key(i);
	}
}

Camera camera;

void load() {
	camera = new Camera();

	objects = new ArrayList<GameObject>();

}

ArrayList<GameObject> objects;

int frameCounter = 0;

void drawGame() {
	for (GameObject o: objects) {
		o.draw();
	}
	fill(255, 150, 0);
	noStroke();
	ellipse(0, 0, 1000, 1000);
}

void debug() {
	fill(0, 0, 0, 150);
	rect(20, 30, 150, 400);
	fill(0, 255, 0);
	text("\nfps:" + frameRate + "\nx: " + camera.transform.position.getX() + " \ny: " + camera.transform.position.getY()+ "\nvx: " + camera.physics.velocity.getX() + " \nvy: " + camera.physics.velocity.getY(), 30, 40);
}

void draw() {
	background(0);
	textFont(courierNew, 12);

	if (frameCounter == 0) {
		load();
	}

	updateKeys();

	mouse.check();

	camera.update(camera);

	pushMatrix();
		translate(-camera.transform.position.getX(), -camera.transform.position.getY());
		drawGame();
	popMatrix();

	debug();

	mouse.draw();

	frameCounter += 1;
}