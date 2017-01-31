/*
 * tentacle onion!
 * by themoep
 * inspired by A Lövely Little Fire: https://gaeel.itch.io/a-lovely-little-fire
 */

// custom variables go here
Onion onion; // our collection of tentacles is called an onion
float t; // t saves the time in seconds

// if you want to see more
boolean debug = false;

public void setup() {
  size(500, 500);
  frameRate(12);
  smooth();
  
  // a fixed seed gives predictable results, eases debugging
  randomSeed(1234);
  noiseSeed(1234);

  // custom setup code goes here 
  onion = new Onion();
  t = 0;
  
  stroke(#f55c5c);
  strokeWeight(15);
  noFill();
}

void draw() {
  // first advance the time
  t += 1/frameRate;
  
  // draw a backgrund, make it blue!
  background(#171a7e);
  
  // update onion values and display it!
  onion.update();
  onion.display();

  // for debugging purposes, set the title to the current framerate
  surface.setTitle(""+frameRate);
}

// on click, save a picture!
void mouseClicked() {
  saveFrame("####-frame.png");
}