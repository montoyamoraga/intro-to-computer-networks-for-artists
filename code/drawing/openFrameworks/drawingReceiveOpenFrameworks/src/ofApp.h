#pragma once

#include "ofMain.h"

// import OSC addon
#include "ofxOsc.h"

// user defined variables

// port for receiving
#define userPortReceive 9002

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
    
        // declare instance of OSC receiver
        ofxOscReceiver myReceiver;
        
        // declare instance of poly line
        ofPolyline line;

        // declare variables for storing values received via OSC
        float receivedX;
        float receivedY;
    
        int maxVertices;
        
};
