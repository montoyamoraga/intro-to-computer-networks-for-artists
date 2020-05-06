#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofSetBackgroundAuto(false);
    ofBackground(0);
    
    midiIn.listInPorts();
    
    midiIn.openPort(2);
    
    midiIn.addListener(this);

}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    
    if (midiMessages.size() > 0) {
        ofxMidiMessage &recentMessage = midiMessages[midiMessages.size() - 1];
        ofDrawCircle(ofMap(recentMessage.pitch, 0, 127, 0, ofGetWidth()), ofMap(recentMessage.velocity, 0, 127, 0, ofGetHeight()), 20);
    }
    
    

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

void ofApp::newMidiMessage(ofxMidiMessage& msg) {
    
    
    
    midiMessages.push_back(msg);
    

    while (midiMessages.size() > maxMessages) {
        midiMessages.erase(midiMessages.begin());
    }
    
    
}
