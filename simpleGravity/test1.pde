float damp = 0.8;
float gravity = 9.81;

void physics(float[] obj) {  /* px, py, vx, vy, ax, ay, rad, col */
  
  obj[4] = 0.0;
  obj[5] = 0.0;
  
  // apply gravity
  
  //obj[5] += gravity * delta / 1000;
  
  // mouse click

  if(mousePressed) {
    float distMouse = sqrt((mouseX - obj[0])*(mouseX - obj[0]) + (mouseY - obj[1])*(mouseY - obj[1]));
    float cosMouse = (mouseX - obj[0]) / distMouse;
    float sinMouse = (mouseY - obj[1]) / distMouse;
    obj[4] += cosMouse * (1000) / (distMouse * distMouse);
    obj[5] += sinMouse * (1000) / (distMouse * distMouse);
  }

  // apply forces
  
  obj[2] += obj[4];
  obj[3] += obj[5];
  obj[0] += obj[2];
  obj[1] += obj[3];

  // check bounds

  if (obj[0] < obj[6]) {
    obj[0] += 2 * (obj[6] - obj[0]);
    obj[2] = -damp * obj[2];
  }
  if (obj[0] > width - obj[6]) {
    obj[0] += 2 * (width - obj[6] - obj[0]);
    obj[2] = -damp * obj[2];
  }
    if (obj[1] < obj[6]) {
    obj[1] += 2 * (obj[6] - obj[1]);
    obj[3] = -damp * obj[3];
  }
  if (obj[1] > height - obj[6]) {
    obj[1] += 2 * (height - obj[6] - obj[1]);
    obj[3] = -damp * obj[3];
  }
  
  fill(obj[7]);
  ellipse(obj[0], obj[1], 2 * obj[6], 2 * obj[6]);
}
