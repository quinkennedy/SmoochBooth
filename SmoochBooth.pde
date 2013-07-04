/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */ 
 
import processing.video.*;
import gifAnimation.*;

Gif gifLoading;
Capture cam;
int timeoutPeriod = 300;
int fadePeriod = 100;
int currTimeout = 0;
int triggerFlashPeriod = 15;
int triggerFlash = 0;
boolean takePic = false;
long picNum = 0;
boolean liveMode = true;
PGraphics toSave;

void setup() {
  setupCamera();
  noCursor();
  size(1024, 768, P2D);
  gifLoading = new Gif(this, "loading.gif");
  gifLoading.loop();
  toSave = createGraphics(1920, 1080);
}

void setupCamera(){
  String[] cameras = Capture.list();
  println("Available cameras:");
  for (int i = 0; i < cameras.length; i++) {
    println(i + "-" + cameras[i]);
  }
  
  // The camera can be initialized directly using an element
  // from the array returned by list():
  //cam = new Capture(this, cameras[15]);//1920, 1080, "Logitech Camera #2", 30);
  cam = new Capture(this);
  cam.start();//18 = smaller
}

void draw() {
  if(liveMode){
    if (cam.available()){
      cam.read();
    }
    pushMatrix();
    translate(width/2, height/2);
    scale(((float)width)/cam.width);
    scale(1, -1);
    imageMode(CENTER);
    image(cam, 0, 0);
    popMatrix();
    return;
  }
  if(triggerFlash > 0){
    background(255);
    triggerFlash--;
    takePic = true;
    return;
  }
  if (takePic && cam.available()){
    cam.read();
    currTimeout = timeoutPeriod;
    takePic = false;
    println("took pic");
  }
  if (currTimeout > 0){
    if (currTimeout == timeoutPeriod){
      saveCam();
    }
    currTimeout--;
    pushMatrix();
    translate(width/2, height/2);
    //scale(width/1920.0);
    //scale(height/1080.0);
    scale(((float)height)/cam.height);
    scale(1, -1);
    imageMode(CENTER);
    image(cam, 0, 0);
    popMatrix();
    //TODO: non-linear? or at least delay before fadeout?
    if (currTimeout < fadePeriod){
      fill(0, 255 - ((float)currTimeout)/fadePeriod*255);
      noStroke();
      rect(0, 0, width, height);
    }
  } else {
    background(0);
  }
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}

void saveCam(){
  println("saving cam");
    cam.save("smoochbooth_"+(picNum++)+".png");
    return;/*
    toSave.beginDraw();
    toSave.imageMode(CENTER);
    toSave.pushMatrix();
     toSave.translate(toSave.width/2, toSave.height/2);
    toSave.scale(1, -1);
    toSave.background(0, 255);
    toSave.set(0, 0, cam);
    //toSave.image(cam, 0, 0);
    toSave.popMatrix();
    toSave.endDraw();
    toSave.get().save("smoochbooth_"+(picNum++)+".png");
*/}

void keyPressed(){
  if (key == ' '){
    if (triggerFlash == 0 && currTimeout < fadePeriod){
      triggerFlash = triggerFlashPeriod;
      println("take pic");
    }
  } else if (key == 't'){
    liveMode = !liveMode;
  }
}
