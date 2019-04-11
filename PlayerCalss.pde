class PLAYER { //<>// //<>//
  MAP world;
  String Skin;
  PVector sclPos;
  PVector vel;
  PVector acc;
  PVector gravity;
  int res;
  int W;
  int H;
  boolean isJumping = false;

  PLAYER(PVector sclPos_, int w_, int h_, MAP world_) {
    sclPos = sclPos_;
    world = world_;
    res = world.RES;
    H = h_;
    W = w_;
    vel = vec(0, 0);
    acc = vec(0, 0);
    gravity = vec(0, .1);
  }
  void render() {
    inputs();
    update();
    fill(#502020, 150);
    rect(getTile(sclPos.x, sclPos.y).pos.x, getTile(sclPos.x, sclPos.y).pos.y, W, H);
    stroke(#df5050, 150);
    strokeWeight(10);
    //point(sclPos.x, sclPos.y);
  }
  void update() {
    if (check(0, 0, 0) && check(0, 1, 0) )
      acc.add(gravity);
    if (!check(0, 1, 0))
      vel.y = 0;
     if (!check(0,0,0))
       sclPos.y--;


    vel.add(acc);
    sclPos.add(vel);
    acc.mult(0);

    vel.x = 0;
  }

  void inputs() {
    if (keyPressed) {
      switch (keyCode) {
      case UP : 
        if (!check(0, 1, 0))
          acc.add(vec(0, -1));
        break;      
      case DOWN :         

        break;      
      case RIGHT : 
        if (check(1, 0, 0))
          acc.add(vec(.5, 0));
        break;
      case LEFT : 
        if (check(-1, 0, 0))
          acc.add(vec(-.5, 0));
        break;
      }
    }
  }
  boolean check(float xOff, float yOff, int ID) {
    TILE trgt1 = getTile(sclPos.x+xOff, sclPos.y+yOff);
    TILE trgt2 = getTile(sclPos.x+xOff, sclPos.y+yOff+1);
    trgt1.isGlow = true;
    return (trgt1.BType == blocks[ID] && trgt2.BType == blocks[ID]);
  }
  TILE getTile(float x, float y) {
    int i = (int) constrain(x, 0, world.GRID.length-1);
    int j = (int) constrain(y, 0, world.GRID[i].length-1);
    return world.GRID[i][j];
  }
}
