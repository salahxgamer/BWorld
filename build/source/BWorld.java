import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BWorld extends PApplet {


int resolution = 10;
float SCALE = 1;
BLOCK[] blocks;

JSONObject json;


ENGINE engine;

public void setup() {



  
  engine = new ENGINE(resolution);
}
public void draw() {
  engine.update(SCALE, ViewOffset);
  engine.render();
}

public void loadTextures() {
  json = loadJSONObject("data.json");
  JSONArray TEXTURESData = json.getJSONArray("Textures");
  blocks = new BLOCK[TEXTURESData.size()];
  for (int i = 0; i < TEXTURESData.size(); i++) {
    JSONObject currBlock =  TEXTURESData.getJSONObject(i);
  }
}
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

  public void render() {
    push();
    translate(vOffset.x, vOffset.y);
    scale(scl);
    background(0xff2196f3);
    world.render();
    pop();
  }
  public void update(float  scl_, PVector vOffset_) {
    scl = scl_;
    vOffset = vOffset_.copy();
  }
}
class MAP {
  //initializing variables
  TILE GRID[][];
  int RES;

  MAP(int RES_) {
    RES = RES_;
    GRID = new TILE[width / RES][height / RES];
    for (int i = 0; i < width / RES; i++) {
      for (int j = 0; j < height / RES; j++) {
        GRID[i][j] = new TILE(getRV(i, j, RES), "AIR", RES);
      }
    }
    println("created MAP World");
  }

  public void render() {
    for (TILE[] tiles : GRID) {
      for (TILE tile : tiles) {
        tile.render();
      }
    }
  }
}

PVector mPress;
PVector prvViewOffset = new PVector();
PVector ViewOffset = new PVector();


public PVector vec(int x, int y) { //fast way of creating a vector;
  return new PVector(x, y);
}


public PVector getRV(int x, int y, int RES) { // get real vector from a scaled cordinations
  return vec(x*RES, y*RES);
}

public PVector getSV(int x, int y, int RES) { // get Scaled vector from a real cordinations
  return vec(x/RES, y/RES);
}

public void mouseWheel(MouseEvent event) { 
  // controls zoom by adjusting the SCALE variable
  float amount = (event.getCount() * 0.1f);
  if (amount < 0.2f) amount *= SCALE;  // to prevent negative numbers and give smooth zoom when extremely zoomed out
  SCALE += amount;
}

public void mousePressed() {
  // saves current view offset and mouse press for later use when mouseDragged
  prvViewOffset = ViewOffset.copy();
  mPress = new PVector(mouseX, mouseY);
}

public void mouseDragged() {
  // adjust the view offset to the relative position of mouse from prev position
  ViewOffset.x = prvViewOffset.x + mouseX - mPress.x; 
  ViewOffset.y = prvViewOffset.y + mouseY - mPress.y;
  println(mouseX, mouseY);
  line(mPress.x, mPress.y, mouseX, mouseY);
}

public void mouseReleased() {
  // adjust the view offset by adding distance of current mouse position from prev position
  ViewOffset = prvViewOffset.copy();
  ViewOffset.x += mouseX - mPress.x;
  ViewOffset.y += mouseY - mPress.y;
}
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
  public void render() {
    int x = (int) pos.x;  // real position;
    int y = (int) pos.y;
    int i = x / RES;      // inGame/map position;
    int j = y / RES;
    colorMode(HSB);
    fill(x * RES % 255, y  * RES % 255, 255);
    rect(pos.x, pos.y, WIDTH, WIDTH);
  }
}
class BLOCK {
  String BlockName;
  String drawMode;
  String fillColor;
  String fillAlpha;
  String strokeColor;
  String strokeAlpha;
  String img_src;
  String svg_src;
  BLOCK(
    String BlockName_, 
    String drawMode_, 
    String fillColor_, 
    String fillAlpha_, 
    String strokeColor_, 
    String strokeAlpha_, 
    String img_src_, 
    String svg_src_) {
  }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BWorld" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
