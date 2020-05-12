#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofSetWindowTitle("sender");
    
    ofSetLineWidth(1);
    
    mySender.setup(HOST, PORT);

}

//--------------------------------------------------------------
void ofApp::update(){
    
    
//
//    for (int i = 0; i < line.size(); i++) {
//        ofxOscMessage myMessage;
//        myMessage.setAddress("/vertex/position");
//        myMessage.addIntArg(line.getVertices()[i].x);
//        myMessage.addIntArg(line.getVertices()[i].y);
//
//        mySender.sendMessage(myMessage, false);
//    }

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
    
    line.addVertex(x, y);
    
    while (line.size() > 128) {
        line.removeVertex(0);
    }
    
    ofxOscMessage myMessage;
    myMessage.setAddress("/vertex/position");
    myMessage.addIntArg(line.getVertices()[line.size() - 1].x);
    myMessage.addIntArg(line.getVertices()[line.size() - 1].y);
    
    mySender.sendMessage(myMessage, false);

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
