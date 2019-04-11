

int resolution = 20;
float SCALE = 1;
BLOCK[] blocks;

JSONObject json;


ENGINE engine;


void setup() {
  size(800, 800);
  loadTextures();
  engine = new ENGINE(resolution);
  //frameRate(5);
}


void draw() {
  engine.update(SCALE, ViewOffset);
  engine.render();
}
