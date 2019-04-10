class TILE {
  //initializing variables
  PVector pos;
  String BType;
  int WIDTH;
  int RES;

  TILE(PVector pos_, String BType_, int RES_) {
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
    colorMode(HSB);
    fill(x * RES % 255, y  * RES % 255, 255);
    rect(pos.x, pos.y, WIDTH, WIDTH);
  }
}
class BLOCK {
  String blockName;
  String drawMode;
  String fillColor;
  String fillAlpha;
  String strokeColor;
  String strokeAlpha;
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
    fillColor = fillColor_;
    fillAlpha = fillAlpha_;
    strokeColor = strokeColor_;
    strokeAlpha = strokeAlpha_;
    img_src = img_src_;
    svg_src = svg_src_;
  }
  String toString() {
    return blockName;
  }
}
