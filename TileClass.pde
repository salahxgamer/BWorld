class TILE {
  //initializing variables
  PVector pos;
  BLOCK BType;
  int WIDTH;
  int RES;
  boolean isGlow = false;

  TILE(PVector pos_, BLOCK BType_, int RES_) {
    RES = RES_;
    pos = pos_;
    BType = BType_;
    WIDTH = RES;
  }
  void render() {
    int x = (int) pos.x;  // real position;
    int y = (int) pos.y;
    //int i = x / RES;      // inGame/map position;
    //int j = y / RES;
    switch (BType.drawMode) {
    case "colorFill" :
      stroke(BType.strokeColor, BType.strokeAlpha);
      fill(BType.fillColor, BType.fillAlpha);
      rect(pos.x, pos.y, WIDTH, WIDTH);
      break;
    case "none" :  
      break;
    default :
      strokeWeight(0.5);
      stroke(#FD0A75, 100);
      fill(#880000, 150);
      rect(x, y, WIDTH, WIDTH);
      break;
    }
    if (isGlow) {
      stroke(#ff5555, 200);
      fill(#ff1010, 100);
      rect(pos.x, pos.y, WIDTH, WIDTH);
      isGlow = false;
    }
  }
  void setBlock(BLOCK block_) {
    BType = block_;
  }
}
class BLOCK {
  String blockName;
  String drawMode;
  int fillColor;
  int fillAlpha;
  int strokeColor;
  int strokeAlpha;
  String img_src;
  String svg_src;
  BLOCK(
    String blockName_, 
    String drawMode_, 
    String fillColor_, 
    String fillAlpha_, 
    String strokeColor_, 
    String strokeAlpha_, 
    String img_src_, 
    String svg_src_) {

    blockName = blockName_;
    drawMode = drawMode_;
    fillColor = strToColor(fillColor_);
    fillAlpha = int(fillAlpha_);
    strokeColor = strToColor(strokeColor_);
    strokeAlpha = int(strokeAlpha_);
    img_src = img_src_;
    svg_src = svg_src_;
  }
  String toString() {
    return blockName;
  }
}
