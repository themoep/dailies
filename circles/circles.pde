
Circle[] circles;
int count = 0;
int maxCount = 50;

void setup() {
  size(500, 500, P2D);
  frameRate(12);

  randomSeed(1234);
  noiseSeed(1234);

  circles = new Circle[maxCount];
}

void draw() {
  background(45);
  
  if (count < maxCount) {
    float maxRadius = 200;
    while (maxRadius > 70) {
      float r = random(10, maxRadius);
      float x = random(r, width-r);
      float y = random(r, height-r);

      Circle newCirc = new Circle(x, y, r);
      //print(".");

      if (count == 0) {
        circles[0] = newCirc;
        count++;
        println("#######");
        break;
      }
      boolean added = false;
      for (int i = 0; i < count; i++) {
        //print(",");
        if (circles[i].overlap(newCirc)) {
          circles[count] = newCirc;
          count++;
          println("+");
          added = true;
          break;
        }
        else {
          println("-");
           maxRadius--;
        }
      }
      if (added) {
        break;
      }
      println("...........................");
     
    }
  }

  for (int i = 0; i < count; i++) {
    circles[i].draw();
  }
}

class Circle {
  PVector position;
  float radius;

  Circle(float x, float y, float r) {
    this.position = new PVector(x, y);
    this.radius = r;
  }

  boolean overlap(Circle other) {
    float d = PVector.dist(this.position, other.position);
    float rr = (this.radius + other.radius);
    println(""+d+" "+rr);
    return (d < rr);
  }

  void draw() {
    ellipse(position.x, position.y, radius, radius);
  }
}


void mouseClicked() {
  saveFrame("####-frame.png");
}