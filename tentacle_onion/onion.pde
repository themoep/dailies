// an onion is mad of tentacles
class Onion {
  int tentacleCount = 80; // amount of tentacles. set lower if your computer runs hot!
  Tentacle[] tentacles;

  // when it is created, we need to make new tentacles
  // this is also called a particle system, in our case
  // the particles are tentacles. how crazy!
  Onion() {
    tentacles = new Tentacle[tentacleCount];
    for (int i = 0; i < tentacleCount; i++) {
      tentacles[i] = new Tentacle();
    }
  }

  // we update every tentacle individually
  void update() {
    for (Tentacle t : tentacles) {
      t.update();
    }
  }

  // we draw every tentacle individually
  void display() {
    for (Tentacle t : tentacles) {
      t.display();
    }
  }
}