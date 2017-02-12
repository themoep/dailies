#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    ofSetLogLevel(OF_LOG_VERBOSE);

    kinect.setRegistration(true);

    kinect.init();

    kinect.open();

    colorImg.allocate(kinect.width, kinect.height);
    grayImage.allocate(kinect.width, kinect.height);

    ofSetFrameRate(60);

}

//--------------------------------------------------------------
void ofApp::update(){
    ofBackground(100,100,100);

    kinect.update();
    if(kinect.isFrameNew()) {
        grayImage.setFromPixels(kinect.getDepthPixels());
        grayImage.flagImageChanged();
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    easyCam.begin();
    //grayImage.draw(0, 0, 1024,780);
    int w = 640;
    int h = 480;
    ofMesh mesh;
    mesh.setMode(OF_PRIMITIVE_POINTS);
    int step = 2;
    for(int y = 0; y < h; y += step) {
        for(int x = 0; x < w; x+=step) {
            if(kinect.getDistanceAt(x,y) > 0) {
                //mesh.addVertex(kinect.getWorldCoordinateAt(x,y));
                
                ofVec3f tmp = kinect.getWorldCoordinateAt(x,y);
                tmp.z -= (int(tmp.z)%50);
                if(tmp.z < 1500) {
                //ofLogNotice() << "value: " << tmp;
                    mesh.addVertex(tmp);
                }
            }
        }
    }
    glPointSize(3);
    ofPushMatrix();
    ofScale(1,-1,-1);
    ofTranslate(0,0,-1000);
    ofEnableDepthTest();
    mesh.drawVertices();
    ofDisableDepthTest();
    ofPopMatrix();

    
    easyCam.end();
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
