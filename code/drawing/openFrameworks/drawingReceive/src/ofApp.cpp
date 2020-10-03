#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofSetWindowTitle("drawingReceive");
    myReceiver.setup(userPortReceive);
    maxVertices = 256;
}

//--------------------------------------------------------------
void ofApp::update(){
    
    // receive messages
    while (myReceiver.hasWaitingMessages()) {
        
        // declare OSC message
        ofxOscMessage myMessage;
        
        // get next message
        myReceiver.getNextMessage(myMessage);
        
        // check that the OSC address matches
        if (myMessage.getAddress() == "/vertex/position") {
            
            // retrieve x, y positions from the message
            receivedX = myMessage.getArgAsInt(0);
            receivedY = myMessage.getArgAsInt(1);
            
            // add x, y position to vertices of line
            line.addVertex(receivedX, receivedY);
        }
    }
    // only keep the latest vertices
    while (line.size() > maxVertices) {
           line.removeVertex(0);
       }
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(255);
    ofSetColor(0, 0, 0);
    line.draw();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    line.clear();
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){
}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){
}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){
}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){
}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){
}
