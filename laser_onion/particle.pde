
Particle newParticle_Highlight() {
  float c = random(0, 1);
  float a = 127;
  float speed = random(1, 100);
  boolean fore = false;
  float seg = 1;
  float x =  width/2;
  float y =  3*height/4+50;
  float ax = width/2;
  float ay = 3*height/4;
  float ar = -10000;
  float rise = 100;
  float grow= 500;
  float dx = cos(a)*speed*2;
  float dy = sin(a)*speed;
  float push = 0;
  float pull = 1+random(0, 1)*2;
  float fric = random(0.3, 0.5);
  float radius = 1;
  float maxradius = 75;
  float fade = 0.5+random(0, 1);
  float r = 255*c; 
  float g = 255*c;
  float b = 255*c*random(0, 1)*0.25;

  return new Particle(c, speed, fore, seg, 
    x, y, ax, ay, ar, rise, 
    grow, dx, dy, push, pull, 
    fric, radius, maxradius, 
    fade, r, g, b, a);
}

Particle newParticle_HighlightMask() {
  float c = 0;
  float a = 255;
  float speed = random(10, 1000);

  float dx = (random(0, 1) > 0.5) ? speed : -speed;

  boolean fore = true;
  float seg = 1;
  float x = width/2+dx/10; 
  float y = 3*height/4+350; 
  float ax = width/2;
  float ay = 3*height/4+10; 
  float ar = 100;
  float rise = random(100, 200); 

  float dy = 0;
  float fade = 0; 
  float grow = random(3, 10); 
  float push = 5;
  float pull = 1+random(0, 1); 
  float fric = random(1, 1.5);
  float fadeIn = 2;
  float radius = 100;
  float maxradius = 100; 
  float r = 0;
  float g = 0; 
  float b = 0; 

  return new Particle(c, speed, fore, seg, 
    x, y, ax, ay, ar, rise, 
    grow, dx, dy, push, pull, 
    fric, radius, maxradius, 
    fade, r, g, b, a);
}

Particle newParticle_HighlightMaskLarge() {
  float c = 0;
  float a = 255;
  float speed = random(10, 1000);

  float dx = (random(0, 1) > 0.5) ? speed : -speed;

  boolean fore = true;
  float seg = 1;
  float x = width/2+dx/10; 
  float y = 3*height/4+125; 
  float ax = width/2;
  float ay = 3*height/4+60; 
  float ar = 60;
  float rise = random(100, 200); 

  float dy = 0;
  float fade = 0; 
  float grow = random(3, 10); 
  float push = 5;
  float pull = 1+random(0, 1); 
  float fric = random(1, 1.5);
  float fadeIn = 2;
  float radius = 10+random(20);
  float maxradius = 100; 
  float r = 0;
  float g = 0; 
  float b = 0; 

  return new Particle(c, speed, fore, seg, 
    x, y, ax, ay, ar, rise, 
    grow, dx, dy, push, pull, 
    fric, radius, maxradius, 
    fade, r, g, b, a);
}

float sign(float in) {
  return in < 0 ? -1 : 1;
}

class Particle {
  float c;
  float speed;
  boolean fore = false;
  float seg;
  float x, y;
  float ax, ay;
  float ar;
  float rise;
  float grow;
  float dx, dy;
  float push;
  float pull;
  float fric;
  float radius; 
  float fadeIn;
  float maxradius;
  float fade;
  float r; 
  float g;
  float b;
  float a;
  float age = 0;

  Particle(float c, float speed, boolean fore, float seg, 
    float x, float y, float ax, float ay, float ar, float rise, 
    float grow, float dx, float dy, float push, float pull, 
    float fric, float radius, float maxradius, 
    float fade, float r, float g, float b, float a) {
    this.c = c;
    this.speed = speed;
    this.fore = fore;
    this.seg = seg;
    this.x = x;
    this.y = y;
    this.ax = ax;
    this.ay = ay;
    this.ar = ar;
    this.rise = rise;
    this.grow= grow;
    this.dx = dx;
    this.dy = dy;
    this.pull = pull;
    this.fric = fric;
    this.radius = radius;
    this.maxradius = maxradius;
    this.fade = fade;
    this.r = 0;//r; 
    this.g = g;
    this.b = b;
    this.a = a;
    this.age = 0;
  }

  // TODO this is if it need to be reset
  boolean pTest() {
    if (this.age > 5 && this.dy > 20) {
      return true;
    }
    if (!this.fore && this.r < 10) {
      return true;
    }
    return this.y< -800 || this.radius < 0;
  }

  void update() {
    float dt = 1/frameRate;
    this.age = this.age + dt;

    // velocity + upwards acceleration
    this.dy = this.dy-this.rise*dt;

    // distance to 'ax/ay'
    float distx = this.ax-this.x;
    float disty = this.ay-this.y;
    float d = sqrt(distx*distx+disty*disty);
    // if distance < a.r+radius, push away?
    if (d < (this.ar+this.radius)) {
      r = 255;
      // apply push force * distance? TODO for some reason doesn't push
      this.dx = this.dx + distx*this.push*dt*2;

      //if (abs(this.dx)<150) {
      //  this.dx = this.dx+sign(this.dx)*10*dt;
      //}
      this.dy = this.dy + disty*this.push*dt;
    } else {
      r = 0;
    }

    // pull towards center but not crossing it much
    float disp = this.x-this.ax;
    this.dx = this.dx-this.dx*this.fric*dt-disp*this.pull*dt;

    // if speed is bigger, grow
    if (this.dy < 50) {
      this.radius = min(this.maxradius, max(0, this.radius + this.grow * dt));
    }

    // fade colours
    //r = r-r*fade*dt;
    g = max(1, this.g-this.g*this.fade*dt);
    b = max(1, this.b-this.b*this.fade*dt);

    // apply velocity
    this.x = this.x+this.dx*dt;
    this.y = this.y+this.dy*dt;
  }

  void display() {

    stroke(r, 255, 255);
    //noStroke();

    fill(r, g, b);
    //fill(0, 1, 5);
    //noFill();
    ellipse(x, y, radius*2, radius*2);
    //point(x,y);
    line(x, y, ax, ay);
    noFill();
    ellipse(ax, ay, ar, ar);
  }
}