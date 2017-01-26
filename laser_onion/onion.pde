

class Onion {
  int tentacleCount = 8;
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
  float angle;
  float magnitude;

  float friction;
  float pull;

  Tentacle() {
    this.unique = random(0, 10);
    this.angle = noise(t+this.unique)*TWO_PI;
    this.magnitude = noise(t+this.unique)*100;

    this.friction = random(0.3, 0.5);
    this.pull = random(1, 2);
  }

  void update() {
    this.angle = noise(t+this.unique)*TWO_PI;
    this.magnitude = noise(t+this.unique)*300;
  }

  void display() {
    PVector pos = new PVector(width/2, height*0.75);
    PVector vel = new PVector(1, 0);
    float dt = 1/frameRate;
    vel.rotate(this.angle);
    vel.mult(this.magnitude);
    PVector prevPos  = pos.copy();
    int i = 0;
    do {
      vel.y -= 100*dt;

      // distance to center
      float distc = pos.x - width/2;
      // TODO friction and pull linear combination, combine!
      vel.x -= vel.x*this.friction*dt + distc*this.pull*dt;

      // apply velocity
      pos.add(PVector.mult(vel, dt));

      line(pos.x, pos.y, prevPos.x, prevPos.y);

      prevPos = pos.copy();

      i++;
      if (i > 40) {
        break;
      }
    } while (pos.x > 0);
  }
}