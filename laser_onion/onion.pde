

class Onion {
  int tentacleCount = 80;
  Tentacle[] tentacles;

  Onion() {
    tentacles = new Tentacle[tentacleCount];
    for (int i = 0; i < tentacleCount; i++) {
      tentacles[i] = new Tentacle();
    }
  }

  void update() {
    for (Tentacle t : tentacles) {
      t.update();
    }
  }

  void display() {
    for (Tentacle t : tentacles) {
      t.display();
    }
  }
}

class Tentacle {

  float unique;
  float unique2;
  float angle;
  float magnitude;

  float friction;
  float pull;

  Tentacle() {
    this.unique = random(0, 1000);
    this.unique2 = random(0, 1000);
    this.angle = noise(t+this.unique)*TWO_PI*2;
    this.magnitude = noise(t+this.unique2)*200;

    println(angle);
    println(magnitude);
    println();

    this.friction = random(0.3, 0.5);
    this.pull = random(1, 2);
  }

  void update() {
    this.angle = noise(t+this.unique)*TWO_PI*2;
    this.magnitude = noise(t+this.unique2)*200;
  }

  void display() {
    PVector pos = new PVector(width/2, height*0.75);
    PVector vel = new PVector(1, 0);
    float dt = 1/frameRate ;
    vel.rotate(this.angle);
    vel.mult(this.magnitude);
    PVector prevPos  = pos.copy();
    int i = 0;

    beginShape();
    curveVertex(pos.x, pos.y);
    do {
      vel.y -= 100*dt;

      // distance to center
      float distc = pos.x - width/2;
      // TODO friction and pull linear combination, combine!
      vel.x -= vel.x*this.friction*dt + distc*this.pull*dt;

      // apply velocity
      pos.add(PVector.mult(vel, dt));

      //line(pos.x, pos.y, prevPos.x, prevPos.y);
      curveVertex(pos.x, pos.y);

      prevPos = pos.copy();

      i++;
      //println(pos.y);
      if (i > 200) {
        break;
      }
      //} while (pos.y > 100);
    } while (i < 20);
    endShape();

    if (false) {
      PVector debug = new PVector(1, 0);
      debug.rotate(this.angle);
      debug.mult(this.magnitude);
      pushStyle();
      strokeWeight(1);
      stroke(0, 255, 255);
      line(width/2, height*0.75, width/2+debug.x, height*0.75+debug.y);
      popStyle();
    }
    //println("----------------------");
  }
}