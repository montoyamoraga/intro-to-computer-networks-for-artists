int numberPoints = 128;

IntList posX = new IntList();
IntList posY = new IntList();


void setup() {

  size(128, 128);
  background(255);
}

void draw() {
  
}

void mouseDragged() {

  posX.append(mouseX);
  posY.append(mouseY);

  while (posX.size() > numberPoints) {
    posX.remove(0);
  }

  while (posY.size() > numberPoints) {
    posY.remove(0);
  }
  
  background(255);

  if ( posX.size() > 1) {
    for (int i = 0; i < posX.size() - 1; i++) {
      line(posX.get(i), posY.get(i),posX.get(i + 1), posY.get(i + 1));
    }
  }


  //println("mouse: "+ mouseX + ", " + mouseY);
}

void mousePressed() {
  background(255);
  posX = new IntList();
  posY = new IntList();
}
