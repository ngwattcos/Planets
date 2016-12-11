PFont monaco;
PFont courierNew;


void setup() {
	size(900, 600, OPENGL);
	frameRate(32);

	monaco = createFont("monaco", 20);
	courierNew = createFont("monaco", 10);

	for (int i = 0; i < keys.length; i++) {
		keys[i] = new Key(i);
	}
}

Camera camera = new Camera();

void load() {

	
	Star sun = new Star("Sun", new Transform(new PVector2D(0, 300)), 300, new Color(255, 150, 0));
	objects.add(sun);

	Planet earth = new Planet("Earth", 30, new Color(0, 150, 255), sun, 600);
	objects.add(earth);
}

ArrayList<GameObject> objects = new ArrayList<GameObject>();

int frameCounter = 0;

void updateGame() {
	for (GameObject o: objects) {
		o.update();
	}
}

void drawGame() {
	for (GameObject o: objects) {
		o.draw();
	}
	fill(255, 150, 0);
	// noStroke();
	// ellipse(0, 0, 1000, 1000);
}

void debug() {
	fill(0, 0, 0, 150);
	rect(20, 30, 150, 400);
	fill(0, 255, 0);
	text("\nfps:" + frameRate + "\nx: " + camera.transform.position.getX() + " \ny: " + camera.transform.position.getY()+ "\nvx: " + camera.physics.velocity.getX() + " \nvy: " + camera.physics.velocity.getY(), 30, 40);
}

void draw() {

	background(0);
	textFont(courierNew, 11);

	if (frameCounter == 10) {
		load();
	}

	updateKeys();

	mouse.check();

	camera.update();

	updateGame();

	pushMatrix();
		translate(-camera.transform.position.getX(), -camera.transform.position.getY());
		drawGame();
	popMatrix();

	debug();

	mouse.draw();

	frameCounter += 1;
}