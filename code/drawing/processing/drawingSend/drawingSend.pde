// about
////////

// intro to computer networks for artists
// a project by aaron montoya-moraga
// available at
// github.com/montoyamoraga/intro-to-computer-networks-for-artists
// started in 2020/05, modified in 2020/10
// v0.0.1

// drawingSend.pde
// this software sends drawing data
// to other computers running the software drawingReceive
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
OscP5 mySender;

// declare object for destination of message
NetAddress myReceiverDestination;

// declare String for storing IP address of receiver
// receiverAddress is a string, 4 numbers in range (255) separated by "."
String receiverAddress = "127.0.0.1";

// port on the receiver where we send our OSC message
int sendPort = 12000;

// port on the sender where we are listening to OSC messages
// not relevant here
int receivePort = 12001;

// variables for drawing
////////////////////////

// two dimensional array of vectors for storing mouse positions
// first dimension is for storing each stroke
// second dimension is for storing the points of each stroke
// each vector stores x and y
ArrayList<ArrayList<PVector>> points = new ArrayList<ArrayList<PVector>>();

// maximum number of strokes stored
int maxStrokes = 8;

// maximum number of vertices stored
int maxPoints = 256;

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

  //OscMessage beginMessage = new OscMessage("/begin");
  //beginMessage.add(points.size());
  //mySender.send(beginMessage, myReceiverDestination);

  //for (int i = 0; i < points.size(); i++) {
  //  for (int j = 0; j < points.get(i).size(); j++) {
  //    OscMessage myMessage = new OscMessage("/points/stroke");
  //    myMessage.add(i);
  //    myMessage.add(int(points.get(i).get(j).x));
  //    myMessage.add(int(points.get(i).get(j).y));
  //    // make the OSC sender send the message to the remote location
  //    mySender.send(myMessage, myReceiverDestination);
  //  }
  //}
  //OscMessage endMessage = new OscMessage("/end");
  //endMessage.add(0);
  //mySender.send(endMessage, myReceiverDestination);
}

// mousePressed() is run every time the mouse is pressed
void mousePressed() {

  // add a new empty stroke per each mouse pressed
  points.add(new ArrayList<PVector>());

  // if there are more strokes than allowed maximum, delete oldest ones 
  while (points.size() > maxStrokes) {
    points.remove(0);
  }
}

// mouseDragged() is run every time the mouse is dragged
void mouseDragged() {

  // add current mouse position to the newest stroke
  points.get(points.size() - 1).add(new PVector(mouseX, mouseY));

  // if vertices has more elements than allowed maximum, delete oldest ones
  while (points.get(points.size() - 1).size() > maxPoints) {
    points.get(points.size() - 1).remove(0);
  }

  // paint background to clear screen
  background(myBackgroundColor);

  for (int i = 0; i < points.size(); i++) {
    for (int j = 0; j < points.get(i).size() - 1; j++) {
      if (j > 0) {
        line(points.get(i).get(j).x, points.get(i).get(j).y, points.get(i).get(j + 1).x, points.get(i).get(j + 1).y);
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    background(myBackgroundColor);

    // clear array of vertices
    points = new ArrayList<ArrayList<PVector>>();
  }

  OscMessage eraseMessage = new OscMessage("/erase");
  mySender.send(eraseMessage, myReceiverDestination);
}

void mouseReleased() {
  OscMessage beginMessage = new OscMessage("/begin");
  beginMessage.add(points.size());
  mySender.send(beginMessage, myReceiverDestination);

  for (int i = 0; i < points.size(); i++) {
    for (int j = 0; j < points.get(i).size(); j++) {
      OscMessage myMessage = new OscMessage("/points/stroke");
      myMessage.add(i);
      myMessage.add(int(points.get(i).get(j).x));
      myMessage.add(int(points.get(i).get(j).y));

      // make the OSC sender send the message to the remote location
      mySender.send(myMessage, myReceiverDestination);
    }
  }
}
