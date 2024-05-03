// Car car;
ArrayList<Car> oldGen, newGen;
ArrayList<ArrayList<Car>> pastGens;
float[] probs, avgScore;
int gens, curGen, geneLength, milliCheck;
float[][] rectList;
float mutChance;
boolean kp;

void setup() {
  size(2600, 600);
  noStroke();
    
  geneLength = 1000;
  milliCheck = 10;
  mutChance = 0.5;
  
  kp = true;
  rectList = new float[][]{
    {0, height/2 - 50, (width - height)/5, 100},
    {(width - height)/5, height/4, 100, height/2},
    {(width - height)/5 + 100, height/4, (width - height)/5, 100},
    {2 * (width - height)/5, height/4 + 100, (width - height)/5, 120},
    {(width - height)/5, 3 * height/4, 2 * (width - height)/5, 80},
    {3 * (width - height)/5, height * 3 / 8, 100, height/2},
    {3 * (width - height)/5, 0, (width - height)/5, height * 3 / 8},
    {4 * (width - height)/5, height * 3 / 8 - 80, (width - height)/5, 80},
    {3 * (width - height)/5, height * 7 / 8 - 80, 3 * (width - height)/10, 100},
    {9 * (width - height)/10 - 100, height * 3 / 8, 100, height/2}
  };
  oldGen = new ArrayList<Car>();
  pastGens = new ArrayList<ArrayList<Car>>();
  avgScore = new float[]{0};
  for (int i = 0; i < 100; i++) {
    oldGen.add(new Car());
    oldGen.get(i).init();
  }
  curGen = 1;
  gens = 5000;
}

void draw() {
  background(34, 177, 76);
  fill(239, 228, 176);
  for (int i = 0; i < rectList.length; i++) {
    rect(rectList[i][0], rectList[i][1], rectList[i][2], rectList[i][3]);
  }
  if (curGen <= gens) {
    for (int i = 0; i < oldGen.size(); i++) {
      oldGen.get(i).run();
    }
    generation();
    text("generation: " + curGen, 10, 10);
  } else {
    text("done", 10, 10);
  }
  averageScores();
}

void keyPressed() {
  kp = !kp;
}

void averageScores() {

  pushMatrix();
  translate(width - height, 0);
  int maxScore = (width - height) * 1000 + geneLength * 30;
  fill(255);
  rect(0, 0, height, height);
  stroke(0);
  strokeWeight(2);
  line(0, 0, 0, height);
  line(0, height, height, height);
  if (avgScore.length > 1) {
    for (int i = 0; i < avgScore.length - 1; i++) {
      stroke(0, 0, 255);
      line(i * height / (avgScore.length - 1), height - avgScore[i] / maxScore * height, (i + 1) * height / (avgScore.length - 1), height - avgScore[i + 1] / maxScore * height);
    }
  }
  /*
  if (avgScore.length > height) {
    for (int i = 0; i < height; i++) {
      stroke(0, 0, 255);
      line(i, height - avgScore[i * (avgScore.length - 1) / height] / maxScore * height, i + 1, height - avgScore[(i + 1) * (avgScore.length - 1) / height] / maxScore * height);
    }
  }
  */
  popMatrix();
  noStroke();
}

void generation() {
  probs = new float[oldGen.size()];
  newGen = new ArrayList<Car>();
  float sumProbs = 0;
  for (int i = 0; i < oldGen.size(); i++) {
    probs[i] = 1 / oldGen.get(i).score;
    sumProbs += probs[i];
  }
  for (int i = 0; i < probs.length; i++) {
    probs[i] = probs[i] / sumProbs;
  }
  for (int i = 0; i < probs.length; i++) {
    newGen.add(new Car());
    for (int j = 0; j < newGen.get(i).steps.length; j++) {
      float findProbs = 0;
      int foundProbs = 0;
      float randProbs = random(0.01, 0.99);
      for (int k = 0; findProbs <= randProbs; k++) {
        findProbs += probs[k];
        foundProbs = k;
      }
      if (random(0, 1) <= mutChance / 100) {
        newGen.get(i).steps[j] = new int[]{int(random(10, 30)), int(random(-2, 2)), int(random(-2, 2))};
      }
      else {
        newGen.get(i).steps[j] = oldGen.get(foundProbs).steps[j];
      }
      newGen.get(i).sumArray += newGen.get(i).steps[j][0];
    }
  }
  float avgSc = 0;
  for (int i = 0; i < oldGen.size(); i++) {
    avgSc += oldGen.get(i).score;
  }
  avgSc = avgSc / oldGen.size();
  avgScore = append(avgScore, avgSc);
  //pastGens.add(oldGen);
  oldGen = newGen;
  curGen++;
}

class Car {
  
  int[][] steps;
  float dist, vmag, score, scalar;
  PVector pos, vdir;
  int[] action;
  int sumArray, timeWent;
  boolean doOnce, notAtEnd;
  
  Car() {
    steps = new int[geneLength][3];
    dist = 0.0;
    sumArray = 0;
    pos = new PVector(20, height/2);
    vdir = new PVector(1.0, 0.0);
    vmag = 0;
    action = new int[3];
    doOnce = true;
    notAtEnd = true;
    score = (width - height) * 1000 + geneLength * 30;
    scalar = 1;
  }
    
  void init() {
    for (int i = 0; i < steps.length; i++) {
      steps[i][0] = int(random(10, 30));
      steps[i][1] = int(random(-2, 2));
      steps[i][2] = int(random(-2, 2));
      sumArray += steps[i][0];
    }
  }
  
  void run() {
    
    for (int timeGo = 0; timeGo < sumArray && notAtEnd; timeGo += milliCheck) {
      int timePassed = 0;
      timeWent = timeGo;
      for (int i = 0; timePassed <= timeGo && i < steps.length; i++) {
        timePassed += steps[i][0];
        action = steps[i];
      }
      this.takeAction();
      if(kp) {
        this.drawCar();
      }
    }
    this.submitScore();
  }
  
  void takeAction() {
    this.inOneRect(rectList);
    vdir.rotate(0.05 * action[2] * vmag * scalar);
    vmag = constrain(vmag + action[1], -5, 10);
    PVector vel = PVector.mult(vdir, vmag * scalar);
    pos.add(vel);
    this.onBound();
  }
  
  void onBound() {
    if (pos.x < 0) {
      pos.x = 0;
      notAtEnd = false;
    } 
    else if (pos.x > width - height) {
      pos.x = width - height;
      notAtEnd = false;
    }
    if (pos.y < 0) {
      pos.y = 0;
      notAtEnd = false;
    } 
    else if (pos.y > height) {
      pos.y = height;
      notAtEnd = false;
    }
    
  }
  
  boolean inRect(float x, float y, float xdist, float ydist) {
    if( x <= pos.x && pos.x <= x + xdist && y <= pos.y && pos.y <= y + ydist) {
      return true;
    } else {
      return false;
    }
  }
  
 void inOneRect(float[][] list) {
   boolean inARect = false;
    for (int i = 0; i < list.length; i++) {
      if (inRect(list[i][0], list[i][1], list[i][2], list[i][3])) {
        inARect = true;
      }
    }
    if (inARect) {
      scalar = 1;
    } else {
      scalar = 0.5;
    }
  }

  void drawCar() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vdir.heading());
    fill(0);
    rect(-14, -6, 21, 12);
    fill(255, 0, 0);
    rect(7, -6, 7, 12);
    popMatrix();
  }
  
  void submitScore() {
    dist = width - height - pos.x;
    if (pos.x == 0) {
      score = float(timeWent);
    } else {
      score = float(sumArray);
    }
    score += dist * 1000;
  }
  
}
