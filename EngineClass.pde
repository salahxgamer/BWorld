class ENGINE {
  //initializing variables
  MAP world;
  PLAYER player;
  int res;
  float scl = 1;
  PVector vOffset = vec(0, 0);


  ENGINE(int res_) {
    res = res_;
    world = new MAP(res);
    player = new PLAYER(vec(width/2, 0), res, res*2,res);
  }

  void render() {
    push();
    translate(vOffset.x, vOffset.y);
    scale(scl);
    background(#2196f3);
    world.render();
    player.render();
    pop();
  }
  void update(float  scl_, PVector vOffset_) {
    scl = scl_;
    vOffset = vOffset_.copy();
  }
}
