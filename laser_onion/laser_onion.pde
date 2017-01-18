// for processsing3 use this library: https://github.com/01010101/GifAnimation

import gifAnimation.*;

boolean renderGif = true;
GifMaker gifExport;
int offset = 200; // because first frames are not so pretty, we skip them
int period = 200; // duration to record, in frames

// custom variables go here
Particles particles;

public void setup() {
  size(600, 600);
  frameRate(12);

  // a fixed seed gives predictable results, eases debugging
  randomSeed(1234);

  if (renderGif) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0); // make it an "endless" animation
    //gifExport.setTransparent(0,0,0); // make black the transparent color. every black pixel in the animation will be transparent
    // GIF doesn't know have alpha values like processing. a pixel can only be totally transparent or totally opaque.
    // set the processing background and the transparent gif color to the same value as the gifs destination background color 
    // (e.g. the website bg-color). Like this you can have the antialiasing from processing in the gif.
  }

  // custom setup code goes here
  particles = new Particles(50, 1);
  background(#6b94e9);
}

void draw() {
  // custom code starts here

  background(#3b5050);
  //background(0);

  particles.update();
  particles.display();

  // custom code ends here

  if (renderGif) { 
    if (frameCount > offset) {
      gifExport.setDelay(1);
      gifExport.addFrame();
    }

    if (frameCount == offset+period) {
      gifExport.finish();
      println("gif saved");
    }
  }
}

void mouseClicked() {
  saveFrame("####-frame.png");
}