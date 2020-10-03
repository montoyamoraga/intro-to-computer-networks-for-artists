// about
////////

// intro to computer networks for artists
// a project by aaron montoya-moraga
// available at
// github.com/montoyamoraga/intro-to-computer-networks-for-artists

// drawingSend.pde
// this is a Processing sketch for sending drawing data
// to other computer using your mouse
// started in may 2020
// modified in october 2020
// v0.0.1

// import libraries
///////////////////

import oscP5.*;
import netP5.*;

// variables for networks
/////////////////////////

// declare object for handling OSC messages
OscP5 mySender;

// declare object for destination of message
NetAddress myReceiverDestination;

// declare String for storing IP address of receiver
String receiverAddress = "127.0.0.1";

// port on the receiver where we send our OSC message
int sendPort = 12000;

// port on the sender where we are listening to OSC messages
// not relevant here
int receivePort = 12001;

// variables for drawing
////////////////////////

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
  mySender = new OscP5(this, receivePort);
  
  // declare destination
  myReceiverDestination = new NetAddress(receiverAddress, sendPort);
}

// draw() is executed after setup() on a loop
// it is empty, but we need it to listen to mouse events
void draw() {
}

// mouseDragged() is run every time the mouse is dragged
void mouseDragged() {

  // add current mouse position to vertices array
  vertices.add(new PVector(mouseX, mouseY));

  // if vertices has more elements than allowed maximum, delete oldest ones
  while (vertices.size() > maxVertices) {
    vertices.remove(0);
  }

  // paint background to clear screen
  background(myBackgroundColor);

  // check if there is more than one vertex
  if (vertices.size() > 1) {
    // draw lines between pairs of vertices, count from 0 to n - 1
    for (int i = 0; i < vertices.size() - 1; i++) {
      line(vertices.get(i).x, vertices.get(i).y, vertices.get(i + 1).x, vertices.get(i + 1).y);
    }
  }

  // declare new OSC message
  OscMessage myMessage = new OscMessage("/vertex/position");

  // append the mouse position to the OSC message
  myMessage.add(mouseX);
  myMessage.add(mouseY);

  // make the OSC sender send the message to the remote location
  mySender.send(myMessage, myReceiverDestination);
}

// this function is run every time the mouse is pressed
void mousePressed() {
  
  // paint background to clear screen
  background(myBackgroundColor);

  // clear array of vertices
  vertices = new ArrayList<PVector>();
}
