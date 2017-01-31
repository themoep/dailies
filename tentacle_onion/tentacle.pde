
class Tentacle {
  float angle;
  float magnitude;
  float angle_adjust;
  float magnitude_adjust;

  float friction;
  float pull;

  color colour;

  Tentacle() {
    // every tentacle has it's own angle and magnitude
    // but also they change differently. this is what
    // we compute here. their uniqueness!
    this.angle_adjust = random(0, 1000);
    this.magnitude_adjust = random(0, 1000);
    this.update();

    // some values that work. I took a peek at a lövely little fire
    // for those numbers to make it nice.
    this.friction = random(0.3, 0.5);
    this.pull = random(1, 2);

    // make it a random colour between pink and yellow
    this.colour = lerpColor(color(#f55c5c), color(#ece98d), random(0, 1));
  }

  void update() {
    // noise makes the tentacles move smoothly, random would make them jump!
    this.angle = noise(t/10+this.angle_adjust)*TWO_PI*2;
    this.magnitude = noise(t/10+this.magnitude_adjust)*300; // this makes the tentacles fan out mre, good for tweak mode!
  }

  void display() {
    // we calculate new positions that we use to draw a shape

    // where we start (it's low to ignore weird glitches I didn't fix)
    PVector pos = new PVector(width/2, height*0.9);
    // the initial velocity is determined by the angle and magnitude
    PVector vel = new PVector(1, 0);
    vel.rotate(this.angle);
    vel.mult(this.magnitude);

    // this is a trick to make it run smoother. 
    // not so important here but another bit inspired by a lövely little fire
    float dt = 1/frameRate ; 
    // this counts how many joints we have drawn
    int joint = 0;
    // This determines how long the tentacles become, good for tweak mode!
    int max_joints = 16;

    // set the colour for this tentacle
    stroke(this.colour);

    beginShape();
    vertex(pos.x, pos.y);
    do {
      // first we add a "rise" force
      vel.y -= 100*dt;

      // we calculate the distance to the center & pull towards it
      float distc = pos.x - width/2;
      vel.x -= vel.x*this.friction*dt + distc*this.pull*dt;

      // apply velocity to the position
      pos.add(PVector.mult(vel, dt));

      // add this point to our shape
      vertex(pos.x, pos.y);

      // and advance
      joint++;
    } while (joint < max_joints);
    endShape();

    if (debug) {
      // draw the angle and magnitude as a line to help see the effects
      PVector debug = new PVector(1, 0);
      debug.rotate(this.angle);
      debug.mult(this.magnitude);
      pushStyle(); // "remember" style settings so we don't have to re-apply them later
      strokeWeight(1);
      stroke(0, 255, 255);
      line(width/2, height*0.90, width/2+debug.x, height*0.90+debug.y);
      popStyle();
    }
  }
}