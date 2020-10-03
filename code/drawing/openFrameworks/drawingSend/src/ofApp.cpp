#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofSetWindowTitle("drawingSend");
    mySender.setup(userIPSend, userPortSend);
    maxVertices = 256;

}

//--------------------------------------------------------------
void ofApp::update(){

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
    
    line.addVertex(x, y);
    
    while (line.size() > maxVertices) {
        line.removeVertex(0);
    }
    
    // declare OSC message
    ofxOscMessage myMessage;
    
    myMessage.setAddress("/vertex/position");
    
    myMessage.addIntArg(x);
    myMessage.addIntArg(y);
    
    mySender.sendMessage(myMessage);
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    
//    ofBackground(255, 255, 255);
//    
//    line.clear();
    

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
