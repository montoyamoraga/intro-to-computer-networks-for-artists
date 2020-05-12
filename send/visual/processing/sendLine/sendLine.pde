import oscP5.*;
import netP5.*;

OscP5 mySender;
NetAddress myRemoteLocation;

String address = "127.0.0.1";
int port = 12345;

int numberPoints = 128;

IntList posX = new IntList();
IntList posY = new IntList();

void setup() {

  size(128, 128);
  background(255);

  mySender = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress(address, port);
}

void draw() {
}

void mouseDragged() {

  posX.append(mouseX);
  posY.append(mouseY);

  OscMessage myMessage = new OscMessage("/vertex/position");

  myMessage.add(mouseX);
  myMessage.add(mouseY);
  
  mySender.send(myMessage, myRemoteLocation);
  
  while (posX.size() > numberPoints) {
    posX.remove(0);
  }

  while (posY.size() > numberPoints) {
    posY.remove(0);
  }

  background(255);

  if ( posX.size() > 1) {
    for (int i = 0; i < posX.size() - 1; i++) {
      line(posX.get(i), posY.get(i), posX.get(i + 1), posY.get(i + 1));
    }
  }


  //println("mouse: "+ mouseX + ", " + mouseY);
}

void mousePressed() {
  background(255);
  posX = new IntList();
  posY = new IntList();
}
