// import libraries
import themidibus.*;

//declare midibus object
MidiBus myBus;

color colorBackground = color(255, 255, 255);
color colorStroke = color(0, 0, 0);
color colorFill = color(random(255), random(255), random(255));

boolean drawStroke = true;
boolean drawFill = true;

int myStrokeWeight = 1;

// setup() happens once, at the beginning
void setup() {
  
  // create canvas
  size(512, 512);
  
  myBus = new MidiBus(this, "from Max 1", -1);
  
  
  
  
  
}

// draw() happens after setup(), on a loop
void draw() {
  
  background(colorBackground);
  
  if (drawStroke) {
    stroke(colorStroke);
    strokeWeight(myStrokeWeight);
  }
  else {
    noStroke();
  }
  
  if (drawFill) {
    fill(colorFill);
  }
  else {
    noFill();
  }
  
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}
