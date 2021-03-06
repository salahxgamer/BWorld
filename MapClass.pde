class MAP {
  //initializing variables
  TILE GRID[][];
  int RES;
  int ROWS;
  int COLS;


  MAP(int RES_) {
    RES = RES_;
    ROWS = width / RES;
    COLS = height / RES;
    // creating a null 2d array
    GRID = new TILE[width / RES][height / RES];
    // filling the 2d space with Tiles with air by default
    for (int i = 0; i < ROWS; i++) {
      for (int j = 0; j < COLS; j++) {
        GRID[i][j] = new TILE(getRV(i, j, RES), blocks[0], RES);
      }
    }
    noiseSeed(31493915);
    println(">> generating the world ...");
    randomBuilder();
  }

  void render() {
    for (TILE[] tiles : GRID) {
      for (TILE tile : tiles) {
        tile.render();
      }
    }
  }
  void randomBuilder() {
    // filling the 2d space with Tiles with air by default
    for (int i = 0; i < ROWS; i++) {
      for (int j = 0; j < COLS; j++) {
        TILE currTile = GRID[i][j];
        int nHeight = (int) map(noise(i*0.01), 0, 1, (ROWS/2) - 50, (ROWS/2) + 20 );

        if (j > nHeight)
          currTile.setBlock(blocks[1]);
        //if (j == nHeight-1 && noise(j) < 0.4) // random generator for structures (trees ...)
        //  currTile.setBlock(blocks[3]);
        if (j == nHeight)
          currTile.setBlock(blocks[2]);
        if (j > nHeight + noise(i*j)*20)
          currTile.setBlock(blocks[3]);
      }
      println(">> generated : " + map(i, 0, (ROWS-1), 0, 100) + "%");
    }
  }
}
