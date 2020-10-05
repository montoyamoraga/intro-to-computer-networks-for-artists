// about
////////

// intro to computer networks for artists
// a project by aaron montoya-moraga
// available at
// github.com/montoyamoraga/intro-to-computer-networks-for-artists
// started in 2020/05, modified in 2020/10
// v0.0.1

// drawingReceive.pde
// this software receives drawing data
// from other computers running the software drawingSend
// this particular script is written in Processing
// there is an alternative version written in openFrameworks
// they are compatible and you can use them interchangeably

// import libraries
///////////////////

import oscP5.*;
import netP5.*;

// variables for networks
/////////////////////////

// declare object for handling OSC messages
OscP5 myReceiver;

// port on the receiver computer to send the OSC message to
int sendPort = 12001;

// port on this sender computer where we are listening to OSC messages
// not relevant here
int receivePort = 12000;

// variables for drawing
////////////////////////

// array of vectors for storing mouse positions
ArrayList<ArrayList<PVector>> points = new ArrayList<ArrayList<PVector>>();

// background color whte
int myBackgroundColor = color(255, 255, 255);

// setup() is executed once, at the beginning
void setup() {

  // create canvas, 256 px width, 256 px height
  size(256, 256);

  // paint canvas background white
  background(myBackgroundColor);

  stroke(0);

  // declare new OscP5 sender, which listens on port
  myReceiver = new OscP5(this, receivePort);
}

// draw() is executed after setup() on a loop
// it is empty, and we need it so that after setup()
void draw() {

  if (receivedMessage) {
    background(myBackgroundColor);

    if (points.size() > 0) {
      for (int i = 0; i < points.size(); i++) {
        if (points.get(i).size() > 2 && points.size() > i) {
          for (int j = 0; j < points.get(i).size() - 1; j++) {
            if (j > 0 && points.size() > i && points.get(i).size() > j) {
              line(int(points.get(i).get(j).x), int(points.get(i).get(j).y), 
                int(points.get(i).get(j + 1).x), int(points.get(i).get(j + 1).y));
            }
          }
        }
      }
    }
  }
  receivedMessage = false;
}

boolean receivedMessage = false;

void oscEvent(OscMessage newMessage) {

  if (newMessage.checkAddrPattern("/begin")) {

    points = new ArrayList<ArrayList<PVector>>();
    for (int i = 0; i < newMessage.get(0).intValue(); i++) {
      points.add(new ArrayList<PVector>());
    }
    receivedMessage = true;
  } else if (newMessage.checkAddrPattern("/points/stroke")) {

    // add current mouse position to vertices array
    points.get(newMessage.get(0).intValue()).add(new PVector(newMessage.get(1).intValue(), newMessage.get(2).intValue()));

    receivedMessage = true;
  } else if (newMessage.checkAddrPattern("/erase")) {
    points = new ArrayList<ArrayList<PVector>>();
    receivedMessage = true;
  }
}
