
ArrayList <Circle> circles = new ArrayList<Circle>();

// todo: draw the radii going around with fading effect?

class Circle {
  float x, y, r, a = 0.0;
  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.a = t;
  }

  Circle(float r) {
    this.x = random(margin, width-margin);
    this.y = random(margin, height-margin);
    this.r = r;
    this.a = t;
  }
}

float diameter = 55;
int margin = 55;

float t = 0;

void setup() {
  size(500, 500, P2D);
  frameRate(12);

  randomSeed(1234);
  noiseSeed(1234);
}

void draw() {
  //background(45, 20);
  noStroke();
  fill(45, 20);
  rect(0,0,width,height);
  t+= 1/frameRate;

  addCircle();


  for (int i = 0; i < circles.size(); i++) {
    Circle c = circles.get(i);
    noStroke();
    fill(#ff8822);
    //ellipse(c.x, c.y, c.r, c.r);

    float x2 = c.r * cos(t-c.a);
    float y2 = c.r * sin(t-c.a);
    strokeWeight(2);
     stroke(0, 128, 255);
    line(c.x, c.y, c.x+x2, c.y+y2);
  }



  /*
  strokeWeight(3);
   stroke(0, 128, 255);
   for (int i = 0; i < circles.size(); i++) {
   float smallest = 100000000;
   int a = -1;
   int b = -1;
   Circle c = circles.get(i);
   for (int j = 0; j < circles.size(); j++) {
   if (j == i) continue;
   Circle d = circles.get(j);
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
   */
}

void addCircle() {
  Circle n = randomCircle();
  int tries = 1000;
  while (overlap(n) && tries > 0) {
    n = randomCircle();
    tries --;
  }
  if (!overlap(n)) {
    circles.add(n);
  } else {
    diameter *=0.9;
    addCircle();
  }
}

Circle randomCircle() {
  return new Circle(diameter);
}


boolean overlap(Circle c) {
  for (Circle p : circles) {
    if (dist(c.x, c.y, p.x, p.y) < (c.r + p.r)*0.5) {
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