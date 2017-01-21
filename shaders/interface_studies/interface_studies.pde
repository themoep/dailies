PShader shader;

FloatList times = new FloatList();
int numTimes = 0;

void setup() {
  size(500, 500, P2D);

  shader = loadShader("shader.frag");
}

void draw() {
  shader.set("u_resolution", float(width), float(height));
  //shader.set("u_mouse", float(mouseX), float(mouseY));
  shader.set("u_time", millis() / 5000.0);
  shader.set("numTimes", numTimes);
  shader.set("times", times.array());
  
  shader(shader);
  rect(0,0,width,height);
}


void mouseClicked() {
  if(times.size()<20) {
    times.append(millis()/5000.0);
  }
  else{
    times.sort();
    for(float e : times) {
      print(""+e+" ");
      println("");
    }
    times.set(0,millis()/ 5000.0);
  }
  numTimes = times.size();
  println(times.size());
}