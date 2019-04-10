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

  void render() {
    for (TILE[] tiles : GRID) {
      for (TILE tile : tiles) {
        tile.render();
      }
    }
  }
}
