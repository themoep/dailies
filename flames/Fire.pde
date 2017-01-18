public enum MType {
  FLAME, SMALL_SMOKE
}

float sign(float x) {
  return (x<0) ? -1 : 1;
}

class Fire {
  Mask[] flames;

  int flameCount = 400;
  int sSmokeCount = 0;

  Fire() {
    flames = new Mask[flameCount+sSmokeCount];
    for (int i = 0; i < flameCount; i++) {
      flames[i] = new Mask(MType.FLAME);
    }
    for (int i = flameCount; i < flameCount+sSmokeCount; i++) {
      flames[i] = new Mask(MType.SMALL_SMOKE);
    }
  }

  void update() {
    for (Mask m : flames) {
      m.update();
    }
  }

  boolean cmp(Mask a, Mask b) {
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
    for (int i = 0; i < flames.length; i++) {
      int curIndex = i;
      Mask brightest = null;
      for (int j = i; j < flames.length; j++) {
        //if (brightness(flames[j].colour) < brightest) {
        if (cmp(flames[j], brightest)) {
          //brightest = brightness(flames[i].colour);
          brightest = flames[j];
          curIndex = j;
        }
      }
      Mask temp = flames[i];
      flames[i] = flames[curIndex];
      flames[curIndex] = temp;
    }
  }

  void display() {
    sortIt();
    for (int i = 0; i < flames.length; i++) {
      flames[i].display();
    }
  }
}

class Mask {
  MType type;

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

  Mask(MType type) {
    this.type = type;
    this.reset();
  }

  void reset() {
    this.age = 0;

    if (this.type == MType.FLAME) {
      // temp vars
      float speed = random(1, 100);
      float c = random(0, 1);

      // actual assignments
      this.fore = false;
      if(mouseX > 0 && mouseX < width) {
        this.position = new PVector(mouseX, mouseY);
      }
      else {
        this.position = new PVector(width/2, height*0.75);
      }
      this.velocity = PVector.random2D();
      this.velocity.mult(speed);
      this.rise = 100;
      this.friction = random(0.3, 0.5);
      this.pull = random(1, 2);
      this.push = 0;
      this.repulsor = new PVector(width/2, height*-1000);
      this.repulseRadius = -100000;
      this.radius = 37;
      this.colour = color(255*c, 255*c, 255*c*random(0, 0.25));
      this.fade = random(0.5, 1.5);
    } else if (this.type == MType.SMALL_SMOKE) {
      // temp vars
      float c = 0;
      float speed = random(10, 1000);
      float dx = (random(0, 1) > 0.5) ? speed : -speed;

      // actual assignments
      this.fore = true;
      this.position = new PVector(width/2+dx/10, height*0.75+5*height/4);
      this.velocity = new PVector(dx, 0);
      this.rise = random(100, 200);
      this.friction = random(1, 1.5);
      this.pull = random(1, 2);
      this.push = 5;
      this.repulsor = new PVector(width/2, 0.75*height+10);
      this.repulseRadius = 100;
      this.radius = 100;
      this.colour = color(0);
      this.fade = 0;
    }
  }

  void update() {
    if (this.outside()) {
      this.reset();
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
    float r = red(colour);
    float g = max(1, green(colour)-green(colour)*this.fade*dt);
    float b =  max(1, blue(colour)-blue(colour)*this.fade*dt);
    colour = color(r, g, b);
  }

  boolean outside() {
    if ((this.position.y + this.radius) < -10 ) {
      return true;
    }
    return false;
  }

  void display() {
    stroke(255);
    noStroke();
    fill(colour);
    ellipse(this.position.x, this.position.y, radius*2, radius*2);
  }
}