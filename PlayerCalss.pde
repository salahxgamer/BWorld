class PLAYER { //<>// //<>//
  String Skin;
  PVector pos;
  PVector sclPos;
  PVector vel;
  PVector acc;
  PVector gravity;
  int res;
  int W;
  int H;
  boolean isJumping = false;

  PLAYER(PVector pos_, int w_, int h_, int res_) {
    pos = pos_;
    res = res_;
    H = h_;
    W = w_;
    vel = vec(0, 0);
    acc = vec(0, 0);
    gravity = vec(0, .8);
  }
  void render() {
    update();

    fill(#205020);
    rect(pos.x-W/2, pos.y, W, H);
    stroke(#df5050, 150);
    strokeWeight(10);
    point(pos.x, pos.y);
  }
  void update() {
    inputs();

    sclPos = getSV(pos.x+1, pos.y+1, res);

    if (check(0, 2, 0))  // if the block below is air
      acc.add(gravity); 

    if (!check(0, 2, 0)) { // if block below isn't air
      if (vel.y >= 0) {
        vel.y = 0;
        pos.y = sclPos.y * res;
      }
      isJumping = false;
      if (!check(0, 1, 0))  // && if the block player is in isn't air
        pos.y -= res;
    }
    if (!check(1, 0, 0) || !check(1, 1, 0)) {
      pos.x = sclPos.x * res;
    }

    vel.x *= 0.01;

    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void inputs() {
    if (keyPressed) {
      switch (keyCode) {
      case UP : 
        if (!isJumping)
          acc.add(vec(0, -5));
        isJumping = true;
        break;      
      case DOWN : 
        acc.add(vec(0, 0));
        break;      
      case RIGHT : 
        if (check(1, 0, 0) && check(1, 1, 0)) 
          acc.add(vec(+5, 0));
        break;      
      case LEFT : 
        if (check(-1, 0, 0) && check(-1, 1, 0)) 
          acc.add(vec(-5, 0));
        break;
      }
    }
  }
  boolean check(float xOff, float yOff, int id) {
    float x = sclPos.x + xOff;
    float y = sclPos.y + yOff;
    return (getTileS(x, y).BType == blocks[id]);
  }
  BLOCK getBlockR(float x, float y) {
    PVector cord = getSV(x, y, res);
    int i = (int) constrain(cord.x, 0, engine.world.GRID.length-1);
    int j = (int) constrain(cord.y, 0, engine.world.GRID[i].length-1);
    BLOCK b = engine.world.GRID[i][j].BType;
    return b;
  }


  BLOCK getBlockS(float x, float y) {
    int i = (int) constrain(x, 0, engine.world.GRID.length-1);
    int j = (int) constrain(y, 0, engine.world.GRID[i].length-1);
    BLOCK b = engine.world.GRID[i][j].BType;
    return b;
  }
  TILE getTileR(float x, float y) {
    PVector cord = getSV(x, y, res);
    return getTileS(cord.x, cord.y);
  }
  TILE getTileS(float x, float y) {
    int i = (int) constrain(x, 0, engine.world.GRID.length-1);
    int j = (int) constrain(y, 0, engine.world.GRID[i].length-1);
    TILE T = engine.world.GRID[i][j];
    return T;
  }
}
