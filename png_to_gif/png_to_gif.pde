PImage image, mask;
int depth, num;
float rad, rotAng;
color small, big;

void setup() {
  size(2000,2000);
  smooth(16);
  background(0);
  fill(255);
  noStroke();
  ellipse(width/2,height/2,width,height);
  saveFrame("maskCircle.png");
  mask = loadImage("maskCircle.png");
  
  num = 6;
  depth = 5;
  rotAng = -PI/2;
  
  small = color(20,0,10); // Only if transparent.
  big = color(0,30,30);
  
  rad = (1 - sin(PI/num))/(1 + sin(PI/num));
  
  background(small);
  image = loadImage("input.png");
  image(image, 0, 0, width, height);
  saveFrame("input.png");
  image = loadImage("input.png");
  image.mask(mask);
  
  background(big);
  image(image, (1.0 - rad) * width/2, (1.0 - rad) * height/2, rad * width, rad * height);
  
  for(int i = 0; i < depth; i++) {
    saveFrame("fractal" + i + ".png");
    PImage tmp = loadImage("fractal" + i + ".png");
    tmp.mask(mask);
    for(int j = 0; j < num; j++) {
      image(tmp, (cos(2 * PI * j / num + rotAng) * (rad + 1) + rad + 1) * width / 4,(sin(2 * PI * j / num + rotAng) * (rad + 1) + rad + 1) * height / 4, (1 - rad) * width / 2, (1 - rad) * height / 2);
    }
  }
}
