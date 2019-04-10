class ENGINE {
  //initializing variables
  MAP world;
  int res;
  float scl = 1;
  PVector vOffset = vec(0, 0);

  ENGINE(int res_) {
    res = res_;
    world = new MAP(res);
  }

  void render() {
    push();
    translate(vOffset.x, vOffset.y);
    scale(scl);
    background(#2196f3);
    world.render();
    pop();
  }
  void update(float  scl_, PVector vOffset_) {
    scl = scl_;
    vOffset = vOffset_.copy();
  }
}
