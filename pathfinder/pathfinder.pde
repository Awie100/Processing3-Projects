/*
The objective of this program is to find the path from the green square to the red square through a random maze.
After reaching the red square the path length will be shown on the screen.
This uses simple pathfinding to accomplish this.
Press [Enter] to pause/start the simulation.
Press [D] to restart the simulation.
Press [Esc] to exit.
Change pixSize to change the complexity of the mazes

Challenge: Try to find the red square before the program does.
*/

boolean[][] map;
int[][] grid;
ArrayList<PVector> stack, path;
PVector start, end;
int col, row, iter, last, pixSize;
boolean pFound, go;

void setup() {

  pixSize = 20;
  
  //size(2000,1500);
  fullScreen();
  
  col = floor(width/pixSize);
  row = floor(height/pixSize);
  
  frameRate(240);
  stroke(255);
  strokeWeight(max(min(width/col,height/row)/5,1));
  textSize(min(height,width)/4);
  
  grid = new int[col][row];
  map = new boolean[2*col+1][2*row+1];
  stack = new ArrayList<PVector>();
  path = new ArrayList<PVector>();
  stack.add(0, new PVector(0,0));
  grid[0][0] = 1;
  start = new PVector(floor(random(1) * col),floor(random(1) * row));
  end = new PVector(floor(random(1) * col),floor(random(1) * row));
  
  for(int i = 0; i < col; i++) {
    for(int j = 0; j < row; j++) {
      map[2*i+1][2*j+1] = true;
    }
  }
  
  generate();
  drawMaze();
  iter = 1;
  path.add(start);
  grid = new int[col][row];
}

void draw() {
  if(pFound) {
    stroke(255,0,0);
    for(int i = 0; i < path.size() - 1; i++) line(path.get(i).x * width / col + width / col / 2, path.get(i).y * height / row + height / row / 2, path.get(i + 1).x * width / col + width / col / 2, path.get(i + 1).y * height / row + height / row / 2);
    fill(50,255,100);
    text(iter, 20, height * 3/4);
  } else {
    noStroke();
    fill(0,255,255);
    for(PVector i : path) ellipse(i.x * width / col + width / col / 2, i.y * height / row + height / row / 2, width / col / 2, height / row / 2);
    if(go) forward();
  }
  if(pFound && go && millis() - last > 2000) {
    pFound = false;
    setup();
  }
}

void drawMaze() {
  background(0);
  
  noStroke();
  fill(0,255,0);
  rect(start.x * width / col, start.y * height / row, width / col, height / row);
  fill(255,0,0);
  rect(end.x * width / col, end.y * height / row, width / col, height / row);
  
  stroke(255);
  for(int i = 0; i < col; i++) {
    for(int j = 0; j < row; j++) {
      int x = 2 * i + 1;
      int y = 2 * j + 1;
      if(!map[x - 1][y]) line(i * width / col, (j + 1) * height / row, i * width / col, j * height / row);
      if(!map[x][y - 1]) line(i * width / col, j * height / row, (i + 1) * width / col, j * height / row);
      if(!map[x + 1][y]) line((i + 1) * width / col, (j + 1) * height / row, (i + 1) * width / col, j * height / row);
      if(!map[x][y + 1]) line(i * width / col, (j + 1) * height / row, (i + 1) * width / col, (j + 1) * height / row);
    }
  }
}

void generate() {
  while (stack.size() > 0) {
    int index = 0; //min(floor(random(stack.size())),floor(random(5))); 
    PVector pos = stack.get(index);
    stack.remove(index);
    ArrayList<PVector> neigh = findN(floor(pos.x), floor(pos.y), 0);
    if (neigh.size() > 0) {
      PVector pos1 = neigh.get(floor(random(1) * neigh.size()));
      stack.add(0, pos);
      stack.add(0, pos1);
      grid[floor(pos1.x)][floor(pos1.y)] = 1;
      map[floor(pos.x + pos1.x + 1)][floor(pos.y + pos1.y + 1)] = true;
    }
  }
}

ArrayList<PVector> findN(int x, int y, int k) {
  ArrayList<PVector> arr = new ArrayList<PVector>();
  if (x > 0 && grid[x - 1][y] == k) {
    arr.add(new PVector(x - 1, y));
  }
  if (x < col - 1 && grid[x + 1][y] == k) {
    arr.add(new PVector(x + 1, y));
  }
  if (y > 0 && grid[x][y - 1] == k) {
    arr.add(new PVector(x, y - 1));
  }
  if (y < row - 1 && grid[x][y + 1] == k) {
    arr.add(new PVector(x, y + 1));
  }
  return arr;
}

void keyPressed() {
  if(key == ENTER) {
    go = !go;
  }
  if(key == 'd') {
    go = false;
    pFound = false;
    setup();
  }
}

void forward() {
  
  ArrayList<PVector> list = new ArrayList<PVector>();
  
  for(PVector p : path) {
    grid[floor(p.x)][floor(p.y)] = iter;
    if(pFound || p.x == end.x && p.y == end.y) {
      backtrace();
      return;
    }
    for(PVector v : findN(floor(p.x),floor(p.y),0)) {
      if(map[floor(p.x +v.x + 1)][floor(p.y +v.y + 1)]) list.add(v);
    }
  }
  path = list;
  iter++;
}

void backtrace() {
  pFound = true;
  last = millis();
  PVector cur = end;
  path = new ArrayList<PVector>();
  path.add(cur);
  for(int i = grid[floor(end.x)][floor(end.y)] - 1; i > 0; i--) {
    cur = findN(floor(cur.x), floor(cur.y), i).get(0);
    path.add(cur);
  }
}
