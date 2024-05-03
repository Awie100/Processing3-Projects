float[][] rainbow = {{1,0,0},{1,1,0},{0,1,0},{0,1,1},{0,0,1},{1,0,1},{1,0,0}};
float[][] jules = {{0,0,1},{1,0,0.5},{0,1,0}};


void setup() {
  size(1000,1000);
  noStroke();
}

void draw() {
  float num = 1000;
  for(float i = 0; i < num; i++) {
    fill(colMap(i / num, rainbow));
    rect(width * i / num, 0, width / num, height);
  }
}

int colMap(float n,float[][] ran) {
  n = n%1 * (ran.length - 1);
  float[] less = ran[floor(n)];
  float[] more = ran[ceil(n)];
  float rCol = lerp(less[0],more[0],n%1)*255;
  float gCol = lerp(less[1],more[1],n%1)*255;
  float bCol = lerp(less[2],more[2],n%1)*255;
  return color(rCol,gCol,bCol);
}
