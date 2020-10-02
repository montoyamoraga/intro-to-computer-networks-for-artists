////////
// about
////////

// intro to computer networks for artists
// a project by aaron montoya-moraga
// available at
// github.com/montoyamoraga/intro-to-computer-networks-for-artists

// drawing_receive.pde
// this is a Processing sketch for receiving drawing data
// from another computer using their mouse
// started in may 2020, modified in october 2020
// v0.0.1

// import libraries
///////////////////

import oscP5.*;
import netP5.*;

// variables for networks
/////////////////////////

// declare object for handling OSC messages
OscP5 myReceiver;

// declare String for storing IP address of receiver
// receiverAddress is a string, 4 numbers in range (255) separated by "."
String receiverAddress = "127.0.0.1";

// port on the receiver where we send our OSC message
int sendPort = 12001;

// port on the sender where we are listening to OSC messages
// not relevant here
int receivePort = 12000;

// variables for drawing
////////////////////////

// declare variables for drawing
// array of vectors for storing mouse positions
ArrayList<PVector> vertices = new ArrayList<PVector>();

// maximum number of vertices stored
int maxVertices = 256;

// background color whte
int myBackgroundColor = color(255, 255, 255);

// setup() is executed once, at the beginning
void setup() {

  // create canvas, 256 px width, 256 px height
  size(256, 256);

  // paint canvas background white
  background(myBackgroundColor);

  // declare new OscP5 sender, which listens on port
  myReceiver = new OscP5(this, receivePort);
}

// draw() is executed after setup() on a loop
// it is empty, and we need it so that after setup()
void draw() {

  // paint background to clear screen
  background(myBackgroundColor);

  // if vertices has more elements than allowed maximum, delete oldest ones
  while (vertices.size() > maxVertices) {
    vertices.remove(0);
  }

  // check if there is more than one vertex
  if (vertices.size() > 1) {
    // draw lines between pairs of vertices, count from 0 to n - 1
    for (int i = 0; i < vertices.size() - 1; i++) {
      line(vertices.get(i).x, vertices.get(i).y, vertices.get(i + 1).x, vertices.get(i + 1).y);
    }
  }
}

void oscEvent(OscMessage newMessage) {
  if (newMessage.checkAddrPattern("/vertex/position")==true) {
    // add current mouse position to vertices array
    vertices.add(new PVector(newMessage.get(0).intValue(), newMessage.get(1).intValue()));
  }
}
