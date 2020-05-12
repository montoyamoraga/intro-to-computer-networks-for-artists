#pragma once

#include "ofMain.h"
#include "ofxOsc.h"

// send host
#define HOST "localhost"

// send port
#define PORT 12345

class ofApp : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();

		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void mouseEntered(int x, int y);
		void mouseExited(int x, int y);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);
    
        // declare a global instance of ofPolyline called line
        ofPolyline line;
    
        // declare instance of ofOscSender called mySender
        ofxOscSender mySender;
    
};
