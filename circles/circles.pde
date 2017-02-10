
ArrayList <PVector> circles = new ArrayList<PVector>();

// todo: draw the radii going around with fading effect?

float diameter = 75;
int margin = 25;

void setup() {
  size(500, 500, P2D);
  frameRate(12);

  randomSeed(1234);
  noiseSeed(1234);
}

void draw() {
  background(45);

  addCircle();


  for (int i = 0; i < circles.size(); i++) {
    PVector c = circles.get(i);
    noStroke();
    fill(#ff8822);
    // ellipse(c.x, c.y, c.z, c.z);
  }




  strokeWeight(3);
  stroke(0, 128, 255);
  for (int i = 0; i < circles.size(); i++) {
    float smallest = 100000000;
    int a = -1;
    int b = -1;
    PVector c = circles.get(i);
    for (int j = 0; j < circles.size(); j++) {
      if (j == i) continue;
      PVector d = circles.get(j);
      float f = dist(c.x, c.y, d.x, d.y);
      if (f < smallest) {
        smallest = f;
        a = i;
        b = j;
      }
    }
    if (a != -1) {
      line(circles.get(a).x, circles.get(a).y, circles.get(b).x, circles.get(b).y);
    }
  }
}

void addCircle() {
  PVector n = randomVector();
  int tries = 1000;
  while (overlap(n) && tries > 0) {
    n = randomVector();
    tries --;
  }
  if (!overlap(n)) {
    circles.add(n);
  } else {
    diameter *=0.9;
    addCircle();
  }
}

PVector randomVector() {
  return new PVector(random(margin, width-margin), random(margin, height-margin), diameter);
}


boolean overlap(PVector c) {
  for (PVector p : circles) {
    if (dist(c.x, c.y, p.x, p.y) < (c.z + p.z)*0.5) {
      return true;
    }
  }
  return false;
}

void mouseClicked() {
  String s = "";

  s += year();   // 2003, 2004, 2005, etc.
  s+= ".";
  s += month();  // Values from 1 - 12
  s+= ".";
  s += day();    // Values from 1 - 31
  s += "_";
  s+= hour();
  s+= minute();
  s+= "-####-frame.png";

  saveFrame(s);
}