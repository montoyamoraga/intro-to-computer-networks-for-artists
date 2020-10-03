#pragma once

#include "ofMain.h"

// import OSC addon
#include "ofxOsc.h"

// user defined variables

// port for receiving
#define userPortSend 12000

#define userIPSend "127.0.0.1"

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
    
        // declare instance of OSC sender
        ofxOscSender mySender;
        
        // declare instance of poly line
        ofPolyline line;

        // declare variables for sending values via OSC
        float sendingX;
        float sendingY;
        
        // max number of vertices of the drawing
        int maxVertices;
		
};
