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

float function1(float x) {
  return cubicPulse(0.5, 0.5, x);
}

float function2(float x) {
  return impulse(5, x);
}

void draw() {
  t+=1/frameRate;
  background(62, 62, 62);
  
  // box drawing
  noFill();
  stroke(240);
  strokeWeight(1);
  translate(width/2, height/2, 0);
  rotateX(-0.2*PI);
  rotateY(t/7);
  box(boxsize);

  translate(-boxsize/2, boxsize/2, boxsize/2);
  strokeWeight(2);

  // Sphere drawing
  PVector pos = new PVector();
  pos.x = (t/10)%1; // 10 seconds to complete a run then start again
  pos.y = function1(pos.x);
  pos.z = function2(pos.y);
  
  pos.x *= boxsize;
  pos.y *= -boxsize;
  pos.z *= -boxsize;
  
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  stroke(#0088FF);
  line(0, 0, 0, pos.x*-1, 0, 0);
  stroke(#FF00FF);
  line(0, 0, 0, 0,pos.y*-1, 0);
  stroke(#FF0000);
  line(0, 0, 0, 0, 0, pos.z*-1);
  stroke(255);
  sphere(5);
  popMatrix();
  
  
  // line drawing

  PVector tmp = new PVector();
  PVector plane1 = new PVector();
  PVector plane2 = new PVector();
  PVector plane3 = new PVector();
  plane1.x = 0;
  plane1.y = function1(0);
  float x, y;

  noFill();
  stroke(255);
  for (int i = 0; i < resolution; i++) {
    x = float(i)/resolution;

    y = function1(x);
    tmp.x = x*boxsize;
    tmp.y = y*-boxsize;
    stroke(255,0,0);
    line(plane1.x, plane1.y, 0, tmp.x, tmp.y, 0); 
    plane1 = tmp.copy();

    pushMatrix();
    rotateY(PI/2.0);
    rotateZ(PI/2);
    rotateY(PI);
    y = function2(x);
    tmp.x = x*boxsize;
    tmp.y = y*-boxsize;
    stroke(#0088FF);
    line(plane2.x, plane2.y, 0, tmp.x, tmp.y, 0); 
    plane2 = tmp.copy();
    popMatrix();

    pushMatrix();
    rotateX(PI/2.0);
    y = function2(function1(x));
    tmp.x = x*boxsize;
    tmp.y = y*-boxsize;
    stroke(255,0,255);
    line(plane3.x, plane3.y, 0, tmp.x, tmp.y, 0); 
    plane3 = tmp.copy();
    popMatrix();
  }

  if (false) {
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
  }


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