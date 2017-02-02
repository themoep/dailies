float t = 0;

float boxsize = 200;
float resolution = 50;

float d = 1/resolution;

void setup() {
  size(500,500,P3D);
  frameRate(12);
  smooth();
  hint(DISABLE_OPTIMIZED_STROKE);
}

void draw() {
  t+=1/frameRate;
  background(62,62,62);
  noFill();
  stroke(240);
  translate(width/2, height/2, 0);
  rotateX(-0.2*PI);
  rotateY(t/5);
  box(boxsize);
  
  translate(-boxsize/2, boxsize/2,boxsize/2);
  
  float x = 0;
  fill(128,0,0,128);
  noStroke();
  beginShape(QUAD_STRIP);
  while(x <= 1.0+d) {
    float y = cubicPulse(0.5, 0.2, x);
    vertex(x*boxsize, y*-boxsize, 0);
    vertex(x*boxsize, y*-boxsize, -boxsize);
    x+=d;
  }
  endShape();
  
  fill(0,0,128,128);
  rotateY(PI/2.0);
  x = 0;
  noStroke();
  beginShape(QUAD_STRIP);
  while(x <= 1.0+d) {
    float y = impulse(5,x);
    vertex(y*boxsize,x*boxsize-boxsize, 0);
    vertex(y*boxsize,x*boxsize-boxsize, boxsize);
    x+=d;
  }
  endShape();
}

float cubicPulse( float c, float w, float x ) {
    x = abs(x - c);
    if( x>w ) return 0.0;
    x /= w;
    return 1.0 - x*x*(3.0-2.0*x);
}

float impulse( float k, float x ) {
    float h = k*x;
    return h*exp(1.0-h);
}