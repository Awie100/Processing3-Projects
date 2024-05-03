float[] objectA = {750, 750, 0, 0, 0, 0, 10, 0, 1};/* px, py, vx, vy, fx, fy, rad, col, mass */
float[] objectB = {625, 700, 0, 0, 0, 0, 20, 25, 4};
float[] objectC = {500, 650, 0, 0, 0, 0, 30, 50, 9};
float[] objectD = {375, 600, 0, 0, 0, 0, 40, 75, 16};
float[] objectE = {250, 550, 0, 0, 0, 0, 50, 100, 25};
int time = 0;
int delta = 0;

void setup() {
  size(1000, 1000);
  smooth();
  noStroke();
}
void draw() {
  background(255);
  delta = millis() - time;
  time = millis();
  physics(objectA);
  physics(objectB);
  physics(objectC);
  physics(objectD);
  physics(objectE);
}
