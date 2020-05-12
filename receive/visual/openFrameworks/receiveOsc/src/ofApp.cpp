#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofSetWindowTitle("receive");
    
    myReceiver.setup(PORT);

}

//--------------------------------------------------------------
void ofApp::update(){
    
    // receive messages
    while (myReceiver.hasWaitingMessages()) {
        
        ofxOscMessage myMessage;
        
        myReceiver.getNextMessage(myMessage);
        
        if (myMessage.getAddress() == "/vertex/position") {
            
            receivedX = myMessage.getArgAsInt(0);
            receivedY = myMessage.getArgAsInt(1);
            
            line.addVertex(receivedX, receivedY);
            
        }
        
    }
    
    while (line.size() > 128) {
           line.removeVertex(0);
       }

}

//--------------------------------------------------------------
void ofApp::draw(){
    
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
