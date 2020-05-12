// sendDrawingProcessing
// draw line with mouse
// on 256x256 canvas
// send a line to an IP address
// may 2020

// import libraries
import oscP5.*;
import netP5.*;

// declare variables for drawing
// array of vectors for storing mouse positions
ArrayList<PVector> vertices = new ArrayList<PVector>();
// maximum number of vertices stored
int maxVertices = 256;

// declare variables for OSC communication
// declare object for sending OSC messages
OscP5 mySender;
// declare object for representing the receivers
NetAddress myReceiver;
// declare String for storing IP address of receiver
// it is a string, between "", made out of 4 numbers separated by periods "."
// TODO: ask the receiver for this IP address
String receiverAddress = "216.180.89.221";
// port on the receiver where we send our OSC message
// TODO: ask the receiver for the port number
int sendPort = 12344;
// port on the sender where we are listening to OSC messages, not relevant here
int receivePort = 12000;

// background color whte
int myBackgroundColor = color(255);

// setup() is executed once, at the beginning
void setup() {

  // create canvas, 256 px width, 256 px height
  size(256, 256);
  
  // paint canvas background white
  background(myBackgroundColor);
  
  // declare new OscP5 sender, which listens on port
  mySender = new OscP5(this, receivePort);
  myReceiver = new NetAddress(receiverAddress, sendPort);
}

// draw() is executed after setup() on a loop
// it is empty, but we need it so that mouse events are triggered
void draw() {
}

// mouseDragged() is triggered every time the mouse is dragged
void mouseDragged() {

  // add current mouse position to vertices array
  vertices.add(new PVector(mouseX, mouseY));
  
  // if vertices has more elements than maximum, delete oldest ones
  while(vertices.size() > maxVertices) {
    vertices.remove(0);
  }
  
  // paint background to clear screen
  background(myBackgroundColor);
  
  // check if there is more than one vertex
  if (vertices.size() > 1) {
    // draw lines from each vertex to the next one
    // iterate from vertex 0 to n - 1
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
  mySender.send(myMessage, myReceiver);
}

// mousePressed() is executed when the mouse is pressed
void mousePressed() {
  // paint background to clear screen
  background(myBackgroundColor);

  // clear array of vertices
  vertices = new ArrayList<PVector>();
}
