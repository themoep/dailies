
Particle newParticleByType(int type) {
  Particle p = null;
  if (type == 1) { // HIGHLIGHT
    p = newParticle_Highlight();
  } 
  if (type == 2) { // HIGHLIGHT MASK
    p =  newParticle_HighlightMask();
  }
  if (type == 3) { // HIGHLIGHT MASK LARGE
    p =  newParticle_HighlightMaskLarge();
  }
  return p;
}


class Particles {
  Particle[] particles;
  Particle[] masks;
  Particle[] masksLarge;
  int type;

  Particles(int count, int type) {
    this.type = type;

    particles = new Particle[count*4];
    masks = new Particle[count];
    masksLarge = new Particle[count];

    for (int i = 0; i < particles.length; i++) {
      particles[i] = newParticleByType(type);
    }
    for (int i = 0; i < masks.length; i++) {
      masks[i] = newParticleByType(type+1);
    }
    for (int i = 0; i < masksLarge.length; i++) {
      masksLarge[i] = newParticleByType(type+2);
    }
  }

  void update() {
    for (int i = 0; i < particles.length; i++) {
      Particle p = particles[i];

      p.update();

      if (p.y < (p.radius*-2)) {
        particles[i] = newParticleByType(this.type);
      }
    }
    for (int i = 0; i < masks.length; i++) {
      Particle m = masks[i];
      m.update();
      if (m.y < (m.radius*-2)) {
        masks[i] = newParticleByType(this.type+1);
      }
    }
    for (int i = 0; i < masksLarge.length; i++) {
      Particle m = masksLarge[i];
      m.update();
      if (m.y < (m.radius*-2)) {
        masksLarge[i] = newParticleByType(this.type+2);
      }
    }
  }

  void display() {
    for (Particle p : particles) {
     // p.display();
    }
    for (Particle m : masks) {
      //m.display();
    }
    for (Particle m : masksLarge) {
      m.display();
    }
  }
}