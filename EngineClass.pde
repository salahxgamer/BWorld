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
    player = new PLAYER(vec(50, 0), res, res*2, world);
  }

  void render() {
    push();
    translate(vOffset.x, vOffset.y);
    scale(scl);
    background(#2196f3);
    world.render();
    player.render();
    if (keyPressed) {
      int buffer = 2*res;
      switch (keyCode) {
      case UP : 
        break;
      case DOWN : 
        break;
      case RIGHT : 
        int lim = world.COLS-buffer ;
        if (player.sclPos.x > lim )
          world.move(int((player.sclPos.x - lim)), 0);
        break;
      case LEFT : 
        if (engine.player.sclPos.x < buffer )
          world.move(int(player.sclPos.x-buffer)/buffer, 0);
        break;
      }
    }


    pop();
  }
  void update(float  scl_, PVector vOffset_) {
    scl = scl_;
    vOffset = vOffset_.copy();
  }
}
