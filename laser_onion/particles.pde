float sign(float x) {
  return (x<0) ? -1 : 1;
}

class Fire {
  Tentacle[] tentacles;

  int flameCount = 20;

  Fire() {
    tentacles = new Tentacle[flameCount];
    for (int i = 0; i < flameCount; i++) {
      tentacles[i] = new Tentacle();
    }
  }

  void update() {
    for (Tentacle m : tentacles) {
      m.update();
    }
  }

  boolean cmp(Tentacle a, Tentacle b) {
    if ( b == null) {
      return true;
    }
    if (a.fore == b.fore) {
      float acol = red(a.colour)+green(a.colour)+blue(a.colour);
      float bcol = red(b.colour)+green(b.colour)+blue(b.colour);
      if (acol==bcol) {
        return a.position.y<b.position.y;
      } else {
        return acol<bcol;
      }
    } else {
      return b.fore;
    }
  }

  void sortIt() {
    for (int i = 0; i < tentacles.length; i++) {
      int curIndex = i;
      Tentacle brightest = null;
      for (int j = i; j < tentacles.length; j++) {
        //if (brightness(tentacles[j].colour) < brightest) {
        if (cmp(tentacles[j], brightest)) {
          //brightest = brightness(tentacles[i].colour);
          brightest = tentacles[j];
          curIndex = j;
        }
      }
      Tentacle temp = tentacles[i];
      tentacles[i] = tentacles[curIndex];
      tentacles[curIndex] = temp;
    }
  }

  void display() {
    //sortIt();
    for (int i = 0; i < tentacles.length; i++) {
      tentacles[i].display();
    }
  }
}

class Tentacle {

  float age;
  boolean fore;
  PVector position;
  PVector velocity;
  float rise;
  float friction;
  float pull;
  float push;
  PVector repulsor;
  float repulseRadius;
  float radius;
  color colour;
  float fade;

  Tentacle() {
    this.age = 0;
    // temp vars
    float speed = random(1, 100);
    float c = random(0, 1);

    // actual assignments
    this.fore = false;
    this.position = new PVector(width/2, height*0.75);
    this.velocity = PVector.random2D();
    this.velocity.mult(speed);
    this.rise = 100;
    this.friction = random(0.3, 0.5);
    this.pull = random(1, 2);
    this.push = 0;
    this.repulsor = new PVector(width/2, height*-1000);
    this.repulseRadius = -100000;
    this.radius = 1;
    this.colour = color(255*c, 255*c, 255*c*random(0, 0.25));
    this.fade = random(0.5, 1.5);
  }

  void reset() {
    this.age = 0;
    // temp vars
    float speed = random(1, 100);
    float c = random(0, 1);

    // actual assignments
    this.fore = false;
    this.position = new PVector(width/2, height*0.75);
    this.velocity = PVector.random2D();
    this.velocity.mult(speed);
    this.rise = 100;
    this.friction = random(0.3, 0.5);
    this.pull = random(1, 2);
    this.push = 0;
    this.repulsor = new PVector(width/2, height*-1000);
    this.repulseRadius = -100000;
    this.radius = 1;
    this.colour = color(255*c, 255*c, 255*c*random(0, 0.25));
    this.fade = random(0.5, 1.5);
  }

  void update() {
    if (this.outside()) {
    }

    float dt = 1/frameRate;
    this.age += dt;

    // apply repulse force
    PVector drep = PVector.sub(this.position, this.repulsor);
    float d = drep.mag();
    if (d < this.repulseRadius+this.radius) {
      this.velocity.add(drep.mult(this.push*dt*2));
      // if it's slow, push it away forcefully to get unstucks
      if (abs(this.velocity.x) < 150) {
        this.velocity.x += sign(this.velocity.x)*100*dt;
      }
    }

    // apply rise force
    this.velocity.y -= this.rise*dt;

    // distance to center
    float distc = this.position.x - width/2;
    // TODO friction and pull linear combination, combine!

    this.velocity.x -= this.velocity.x*this.friction*dt + distc*this.pull*dt;

    // apply velocity
    this.position.add(PVector.mult(this.velocity, dt));

    // adjust color
    //float r = red(colour);
    //float g = max(1, green(colour)-green(colour)*this.fade*dt);
    //float b =  max(1, blue(colour)-blue(colour)*this.fade*dt);
    //colour = color(r, g, b);
  }

  boolean outside() {
    if ((this.position.y + this.radius) < -10 ) {
      return true;
    }
    return false;
  }

  boolean inside() {
    return ! this.outside();
  }

  void display() {
    PVector prev = new PVector(this.position.x, this.position.y);

    while (this.inside()) {

      //point(this.position.x, this.position.y);
      update();

      line(this.position.x, this.position.y, prev.x, prev.y);
      prev.x = this.position.x;
      prev.y = this.position.y;
    }
    this.reset();
    //stroke(255);
    //noStroke();
    //fill(colour);
    //ellipse(this.position.x, this.position.y, radius*2, radius*2);
    //point(this.position.x, this.position.y);
  }
}