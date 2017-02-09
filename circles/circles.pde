
ArrayList <PVector> circles = new ArrayList<PVector>();

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
    ellipse(c.x, c.y, c.z, c.z);
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
  saveFrame("####-frame.png");
}