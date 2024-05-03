boolean[][][] grid;
ArrayList<PVector> stack;
int row, col;

void setup() {
  size(1500,1500);
  row = 200;
  col = 200;
  grid = new boolean[row][col][5];
  stack = new ArrayList<PVector>();
  stack.add(0, new PVector(0,0));
  grid[0][0][4] = true;
  generate();
  stroke(255);
  strokeWeight(2);
}

void draw() {
  background(0);
  for(int i = 0; i < row; i++) {
    for(int j = 0; j < col; j++) {
      int x = i * height / row;
      int y = j * width / col;
      if(!grid[i][j][0]) line(x, y + width / col, x, y);
      if(!grid[i][j][1]) line(x, y, x + height / row, y);
      if(!grid[i][j][2]) line(x + height / row, y + width / col, x + height / row, y);
      if(!grid[i][j][3]) line(x, y + width / col, x + height / row, y + width / col);
    }
  }
}

void generate() {
  while (stack.size() > 0) {
    PVector pos = stack.get(0);
    stack.remove(0);
    ArrayList<PVector> neigh = findN(floor(pos.x), floor(pos.y));
    if (neigh.size() > 0) {
      PVector pos1 = neigh.get(floor(random(1) * neigh.size()));
      int four = abs(floor((pos.x - pos1.x) + 2 * (pos.y - pos1.y) - 1));
      stack.add(0, pos);
      stack.add(0, pos1);
      grid[floor(pos1.x)][floor(pos1.y)][4] = true;
      grid[floor(pos.x)][floor(pos.y)][four] = true;
      grid[floor(pos1.x)][floor(pos1.y)][(four + 2) % 4] = true;
    }
  }
}

ArrayList<PVector> findN(int x, int y) {
  ArrayList<PVector> arr = new ArrayList<PVector>();
  if (x > 0 && !grid[x - 1][y][4]) {
    arr.add(new PVector(x - 1, y));
  }
  if (x < row - 1 && !grid[x + 1][y][4]) {
    arr.add(new PVector(x + 1, y));
  }
  if (y > 0 && !grid[x][y - 1][4]) {
    arr.add(new PVector(x, y - 1));
  }
  if (y < col - 1 && !grid[x][y + 1][4]) {
    arr.add(new PVector(x, y + 1));
  }
  return arr;
}
