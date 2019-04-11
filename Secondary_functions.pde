PVector mPress;
PVector prvViewOffset = new PVector();
PVector ViewOffset = new PVector();


PVector vec(float x, float y) { //fast way of creating a vector;
  return new PVector(x, y);
}


PVector getRV(float x, float y, float RES) { // get real vector from a scaled cordinations
  return vec(x*RES, y*RES);
}

PVector getSV(float x, float y, int RES) { // get Scaled vector from a real cordinations
  x = (int) x/RES;
  y = (int) y/RES;
  return vec(x, y);
}

void mouseWheel(MouseEvent event) { 
  // controls zoom by adjusting the SCALE variable
  float amount = (event.getCount() * 0.1);
  if (amount < 0.2) amount *= SCALE;  // to prevent negative numbers and give smooth zoom when extremely zoomed out
  SCALE += amount;
}

void mousePressed() {
  // saves current view offset and mouse press for later use when mouseDragged
  prvViewOffset = ViewOffset.copy();
  mPress = new PVector(mouseX, mouseY);
}

void mouseDragged() {
  // adjust the view offset to the relative position of mouse from prev position
  ViewOffset.x = prvViewOffset.x + mouseX - mPress.x; 
  ViewOffset.y = prvViewOffset.y + mouseY - mPress.y;
  line(mPress.x, mPress.y, mouseX, mouseY);
}

void mouseReleased() {
  // adjust the view offset by adding distance of current mouse position from prev position
  ViewOffset = prvViewOffset.copy();
  ViewOffset.x += mouseX - mPress.x;
  ViewOffset.y += mouseY - mPress.y;
}

void loadTextures() {
  json = loadJSONObject("data.json");
  JSONArray TEXTURESData = json.getJSONArray("Textures");
  blocks = new BLOCK[TEXTURESData.size()];

  for (int i = 0; i < TEXTURESData.size(); i++) {
    JSONObject currBlock =  TEXTURESData.getJSONObject(i);
    String blockName = currBlock.getString("blockName");
    String drawMode = currBlock.getString("drawMode");

    JSONObject colors = currBlock.getJSONObject("colors");
    String fillColor = colors.getString("fillColor");
    String fillAlpha = colors.getString("fillAlpha");
    String strokeColor = colors.getString("strokeColor");
    String strokeAlpha = colors.getString("strokeAlpha");

    JSONObject img = currBlock.getJSONObject("img");
    String img_src = img.getString("Source");

    JSONObject svg = currBlock.getJSONObject("svg");
    String svg_src = svg.getString("Source");

    blocks[i] = new BLOCK(blockName, drawMode, fillColor, fillAlpha, strokeColor, strokeAlpha, img_src, svg_src);
  }
}

// converts a strin like "#AABBCC" into a color by replaceing # with FF , it would be then "FFAABBCC" and unhexes it
color strToColor(String str) {
  if (str.length() > 6) {
    str = "FF" + (str + "000000").substring(1, 7);
    return unhex(str);
  }
  return #000000;
}
