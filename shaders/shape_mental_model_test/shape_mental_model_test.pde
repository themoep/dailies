float t = 0;

float boxsize = 200;
float resolution = 50;

float d = 1/resolution;

void setup() {
  size(500, 500, P3D);
  frameRate(12);
  smooth();
  hint(DISABLE_OPTIMIZED_STROKE);
}

void draw() {
  t+=1/frameRate;
  background(62, 62, 62);
  noFill();
  stroke(240);
  translate(width/2, height/2, 0);
  sphere(10);
  rotateX(-0.2*PI);
  rotateY(t/7);
  box(boxsize);

  translate(-boxsize/2, boxsize/2, boxsize/2);

  float x1 = (t/10)%1; // 10 seconds to complete a run then start again
  float x2 = cubicPulse(0.5, 0.2, x1);
  float y1 = impulse(5, x2);

  // DEBUG
  noStroke();
  fill(255, 0, 0);
  pushMatrix();
  sphere(10);
  popMatrix();

  noStroke();
  fill(0, 255, 0);
  pushMatrix();
  translate(boxsize, 0, 0);
  sphere(10);
  popMatrix();

  noStroke();
  fill(0, 0, 255);
  pushMatrix();
  translate(0, -boxsize, 0);
  sphere(10);
  popMatrix();

  noStroke();
  fill(255, 0, 255);
  pushMatrix();
  translate(0, 0, -boxsize);
  sphere(10);
  popMatrix();

  // STATIC CURVE DRAW
  PVector a = new PVector();
  PVector b = new PVector();
  float x = 0;
  noFill();
  stroke(255);
  a.x = 0;
  a.y = cubicPulse(0.5, 0.2, 0)*-boxsize;
  while (x <= 1.0+d) {
    float y = cubicPulse(0.5, 0.2, x);
    b.x = x*boxsize;
    b.y = y*-boxsize;
    line(a.x, a.y, 0, b.x, b.y, 0);
    a = b.copy();
    x+=d;
  }

  pushMatrix();
  rotateY(PI/2.0);
  rotateZ(PI/2);
  rotateY(PI);
  x = 0;
  a = new PVector();
  b = new PVector();
  a.x = 0;
  a.y = impulse(5, 0)*-boxsize;
  while (x <= 1.0+d) {
    float y = impulse(5, x);
    b.x = x*boxsize;
    b.y = y*-boxsize;
    line(a.x, a.y, 0, b.x, b.y, 0);
    a = b.copy();
    x+=d;
  }
  popMatrix();

  pushMatrix();
  rotateX(PI/2.0);
  x = 0;
  a = new PVector();
  b = new PVector();
  a.x = 0;
  a.y = impulse(5, 0)*-boxsize;
  while (x <= 1.0+d) {
    float y =  impulse(5, cubicPulse(0.5, 0.2, x));
    b.x = x*boxsize;
    b.y = y*-boxsize;
    line(a.x, a.y, 0, b.x, b.y, 0);
    a = b.copy();
    x+=d;
  }
  popMatrix();
}

float cubicPulse( float c, float w, float x ) {
  x = abs(x - c);
  if ( x>w ) return 0.0;
  x /= w;
  return 1.0 - x*x*(3.0-2.0*x);
}

float impulse( float k, float x ) {
  float h = k*x;
  return h*exp(1.0-h);
}

void mouseClicked() {
  saveFrame("#####-frame.png");
}