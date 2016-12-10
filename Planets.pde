void setup() {
	size(900, 600);
	for (int i = 0; i < keys.length; i++) {
		keys[i] = new Key(i);
	}
}

Camera camera;

void load() {
	camera = new Camera();


}

int frameCounter = 0;

void draw() {
	background(0);

	if (frameCounter == 0) {
		load();
	}

	updateKeys();

	mouse.check();

	camera.update();

	mouse.draw();
}