boolean[][] grid, map;
ArrayList<PVector> stack;
int row, col;

void setup() {
  row = 60;
  col = 60;
  
  size(1500,1500);
  strokeWeight(max(min(width/row,height/col)/5,1));
  
  grid = new boolean[row][col];
  map = new boolean[2*row+1][2*col+1];
  stack = new ArrayList<PVector>();
  stack.add(0, new PVector(0,0));
  grid[0][0] = true;
  
  for(int i = 0; i < row; i++) {
    for(int j = 0; j < col; j++) {
      map[2*i+1][2*j+1] = true;
    }
  }
  
  generate();
}

void draw() {
  background(0);
  noStroke();
  fill(0, 255, 0);
  rect(0, 0, width / col, height / row);
  fill(255, 0, 0);
  rect(width - width / col, height - height / row, width / col, height / row);
  
  stroke(255);
  for(int i = 0; i < row; i++) {
    for(int j = 0; j < col; j++) {
      int x = 2 * i + 1;
      int y = 2 * j + 1;
      if(!map[x - 1][y]) line(i * height / row, (j + 1) * width / col, i * height / row, j * width / col);
      if(!map[x][y - 1]) line(i * height / row, j * width / col, (i + 1) * height / row, j * width / col);
      if(!map[x + 1][y]) line((i + 1) * height / row, (j + 1) * width / col, (i + 1) * height / row, j * width / col);
      if(!map[x][y + 1]) line(i * height / row, (j + 1) * width / col, (i + 1) * height / row, (j + 1) * width / col);
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
      stack.add(0, pos);
      stack.add(0, pos1);
      grid[floor(pos1.x)][floor(pos1.y)] = true;
      map[floor(pos.x + pos1.x + 1)][floor(pos.y + pos1.y + 1)] = true;
    }
  }
}

ArrayList<PVector> findN(int x, int y) {
  ArrayList<PVector> arr = new ArrayList<PVector>();
  if (x > 0 && !grid[x - 1][y]) {
    arr.add(new PVector(x - 1, y));
  }
  if (x < row - 1 && !grid[x + 1][y]) {
    arr.add(new PVector(x + 1, y));
  }
  if (y > 0 && !grid[x][y - 1]) {
    arr.add(new PVector(x, y - 1));
  }
  if (y < col - 1 && !grid[x][y + 1]) {
    arr.add(new PVector(x, y + 1));
  }
  return arr;
}

void keyPressed() {
  if(key == ENTER) {
    String out = "{{";
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[0].length; j++) {
        out = out + !map[i][j] + ",";
      }
      out = out.substring(0,out.length() - 1);
      out = out + "},{";
    }
    print(out.substring(0,out.length() - 2) + "}");
  }
}
