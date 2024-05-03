import java.awt.*;

boolean[][] map = {{true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,true,true,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,true,true,false,true,true,false,false,false,false,false,true,false,false,false,true,false,false,true,true,true,true,true,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,true,false,false,false,false,true,false,false,false,false,false,true},{true,false,false,false,true,true,true,true,true,false,false,false,false,false,true,true,true,true,true,false,false,false,false,true,false,false,false,false,false,true},{true,false,false,false,true,true,true,true,true,false,false,false,false,false,true,false,false,false,true,false,false,false,false,true,false,false,false,false,false,true},{true,false,false,false,true,true,true,true,true,false,false,false,false,false,true,false,false,false,true,false,false,true,true,true,true,true,false,false,false,true},{true,false,false,false,false,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,false,false,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,false,true,true,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},{true,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,true,true,true,true,true,true,true,true,true,true},{true,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,true,false,true,false,false,false,false,false,false,false,false,false,true},{true,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,true,false,true,false,true,false,true,false,true,true,true,true,true},{true,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,true,false,true,false,true,false,true,false,false,false,true,false,false},{true,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,true,false,true,true,true,false,true,true,true,true,true,false,true},{true,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,true,false,false,false,false,false,false,false,false,false,true,false,true},{true,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,true,false,true,true,true,true,true,true,true,true,true,false,true},{true,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,true,false,true,false,false,false,false,false,true,false,false,false,true},{true,true,true,false,false,false,false,false,false,false,true,false,false,false,false,false,false,true,false,true,false,true,true,true,false,true,false,true,true,true},{true,true,true,true,true,false,false,false,true,true,false,false,false,false,false,false,false,true,false,false,false,false,true,false,false,false,false,false,false,true},{true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true}};
PVector eyePos, eyeVel;
float eyeAng, dist, stepSize, speed, dpi;
int maxSteps, frameRateMax;
boolean map3d, doOnce, wall;
int[] keys;

void setup() {
  frameRateMax = 60;
  dpi = 0.45;
  
  frameRate(frameRateMax);
  size(1200,900);
  map3d = false;
  doOnce = false;
  
  eyePos = new PVector(10,12);
  eyeVel = new PVector(0,0);
  keys = new int[4];
  dist = width/2;
  stepSize = 0.002;
  maxSteps = 20000;
  speed = 4;
}

void draw() {
  background(51,153,255);
  eyeAng = eyeAng % (2 * PI);
  move();
  if(map3d){
    noCursor();
    raycast();
  } else {
    cursor(0);
    minimap();
  }
  text(frameRate, 10, 20);
  text("Don't Press WASD.", 10, 32);
  text("(Or Enter)", 10, 44);
  
}

void keyPressed() {
  
  switch(key) {
    case 'w':
      keys[0] = 1;
      break;
    case 's':
      keys[1] = 1;
      break;
    case 'a':
      keys[2] = 1;
      break;
    case 'd':
      keys[3] = 1;
      break;
    case ENTER:
      map3d = !map3d;
      break;
    case 'j':
      printMap();
      break;
    default:
      break;
  }
}

void move() {
  
  float x = eyePos.x;
  float y = eyePos.y;
  
  eyeVel = new PVector(keys[0] - keys[1],keys[3] - keys[2]).setMag(speed / frameRate).rotate(eyeAng);
  eyePos.add(eyeVel);
  
  if(map.length + 1 > eyePos.y && eyePos.y >= 1 && map[0].length + 1 > eyePos.x && eyePos.x >= 1 && map[int(eyePos.y) - 1][int(eyePos.x) - 1]) {
    eyePos = new PVector(x,y);
  }
}

void keyReleased() {
  
  switch(key) {
    case 'w':
      keys[0] = 0;
      break;
    case 's':
      keys[1] = 0;
      break;
    case 'a':
      keys[2] = 0;
      break;
    case 'd':
      keys[3] = 0;
      break;
    default:
      break;
  }
}

float highFunc(float x,float y) {
  x = (x % 1) - 0.5;
  y = (y % 1) - 0.5;
  return abs(x + y);
}

void raycast() {
  
  fill(0,153,0);
  stroke(0,153,0);
  rect(0, height/2, width, height/2);
  
  for(int i = 0; i < width; i++) {
    
    PVector ray = new PVector(stepSize,0);
    float rotAng = -atan2(width/2 - i, dist);
    ray.rotate(eyeAng + rotAng);
    
    int iter = 0;
    while(iter < maxSteps) {
      float x = eyePos.x + ray.x * iter;
      float y = eyePos.y + ray.y * iter;
      if (map.length + 1 > y && y >= 1 && map[0].length + 1 > x && x >= 1 && map[int(y)-1][int(x)-1]) {
        if (abs(x % 1 - 0.5) > 0.45 && abs(y % 1 - 0.5) > 0.45) stroke(102,51,0); else stroke(153,76,0);
        float lineHeight = float(height) / (stepSize * iter * cos(rotAng));
        line(i,(height - lineHeight)/2,i,(height + lineHeight)/2);
        stroke(102,51,0);
        line(i,(height - lineHeight)/2 - (highFunc(x, y) - 5.0 / height - 1) * lineHeight,i,(height - lineHeight)/2 - (highFunc(x, y) + 5.0 / height - 1) * lineHeight);
        break;
      }
      iter++;
    }
  }
}

void minimap() {
  
  int small;
  PVector trans;
  
  pushMatrix();
  if(height < width) {
    trans = new PVector((width - height) / 2,0);
    small = height;
  } else {
    trans = new PVector(0, (height - width) / 2);
    small = width;
  }
  
  translate(trans.x, trans.y);
  eyeAng = atan2(mouseY - (eyePos.y - 1) * small / map.length - trans.y, mouseX - (eyePos.x - 1) * small / map[0].length - trans.x);
  
  fill(0,153,0);
  rect(0,0,small,small);
  fill(153,76,0);
  stroke(102,51,0);
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[0].length; j++) {
      if (map[i][j]) rect(j * small / map[0].length, i * small / map.length, small / map[0].length, small / map.length);
    }
  }
  
  ellipse((eyePos.x - 1) * small / map[0].length, (eyePos.y - 1) * small / map.length, small / map[0].length, small / map.length);
  fill(102,51,0);
  ellipse((eyePos.x - 1 + cos(eyeAng) / 4) * small / map[0].length, (eyePos.y - 1 + sin(eyeAng) / 4) * small / map.length, small / map[0].length / 2, small / map.length / 2);
  popMatrix();
  
  if (mousePressed) {
    int posX = constrain((mouseX - int(trans.x)) * map[0].length / small, 0, map[0].length - 1);
    int posY = constrain((mouseY - int(trans.y)) * map.length / small, 0, map.length - 1);
    if (!doOnce) {
      wall = !map[posY][posX];
      doOnce = true;
    }
    map[posY][posX] = wall;
  }
}

void mouseMoved() {
  if (map3d) {
    eyeAng -= float(width -  2 * mouseX) / width * PI / frameRate * dpi;
    try{
    Robot robot = new Robot();
    Component comp = ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
    Point point = comp.getLocationOnScreen();
    if(comp.isShowing()) robot.mouseMove(width/2 + 3 + point.x,height/2 + 3 + point.y);
    } catch (AWTException e) {
    }
  }
}

void printMap() {
  String out = "{{";
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[0].length; j++) {
        out = out + map[i][j] + ",";
      }
      out = out.substring(0,out.length() - 1);
      out = out + "},{";
    }
    print(out.substring(0,out.length() - 2) + "}");
}

void mouseReleased() {
  doOnce = false;
}
