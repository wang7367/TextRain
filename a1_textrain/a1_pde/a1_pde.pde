/*
 * CSci-4611 Assignment #1 Text Rain
 */


import processing.video.*;

// Global variables for handling video data and the input selection screen
String[] cameras;
Capture cam;
Movie mov;
PImage inputImage;
boolean inputMethodSelected = false;

int gap=0;

static int numOfChar;

char[] array;
boolean[] fall;
float[] y;
float[] x;
color[] c=new color[1280*720];

color[] charC;

float[] vel;

static float gravity=5;

PImage flippedImage;

float threshold=128;
int debugGfx=0;
void setup() {
  size(1280, 720);  
  inputImage = createImage(width, height, RGB);
  flippedImage=createImage(width,height,RGB);
  String noSpace=new String();
  String[] lines=loadStrings("TheRainyDay.txt");
  for(int i=0;i<lines.length;i++){
   char[] text=lines[i].toCharArray();
   for(char x : text){
     noSpace+=x; 
    }
   }
   println(noSpace.charAt(38));
   numOfChar=noSpace.length();
   array=new char[numOfChar];
   fall=new boolean[numOfChar];
   y=new float[numOfChar];
   x=new float[numOfChar];
   vel=new float[numOfChar];
   charC=new color[numOfChar];
  
   PFont font=loadFont("AgencyFB-Bold-48.vlw");

   textFont(font,30);
   for(int i=0; i<numOfChar; i++){
     array[i]=noSpace.charAt(i);
     charC[i]=color(random(255),random(255),random(255));
   }
    for(int i=0; i<numOfChar; i++){
       x[i]=int(random(20,1080));
       for(int j=i+1;j<numOfChar;j++){
          if(array[j]!=' '){
             x[j]=x[j-1]+15;        
          }else{
           i=j;
          j=numOfChar;
          }
          if(j==numOfChar-1){
            i=j;
          }
       }
   }

}

int counter;
//int timer;

void draw() {
 
  // When the program first starts, draw a menu of different options for which camera to use for input
  // The input method is selected by pressing a key 0-9 on the keyboard
  if (!inputMethodSelected) {
    cameras = Capture.list();
    int y=40;
    text("O: Offline mode, test with TextRainInput.mov movie file instead of live camera feed.", 20, y);
    y += 40; 
    for (int i = 0; i < min(9,cameras.length); i++) {
      text(i+1 + ": " + cameras[i], 20, y);
      y += 40;
    }
    return;
  }

  // This part of the draw loop gets called after the input selection screen, during normal execution of the program.
  
  // STEP 1.  Load an image, either from a movie file or from a live camera feed. Store the result in the inputImage variable
  if ((cam != null) && (cam.available())) {
    cam.read();
    inputImage.copy(cam, 0,0,cam.width,cam.height, 0,0,inputImage.width,inputImage.height);
  }
  else if ((mov != null) && (mov.available())) {
    mov.read();
    inputImage.copy(mov, 0,0,mov.width,mov.height, 0,0,inputImage.width,inputImage.height);
  }


  // This code draws the current camera/movie image to the screen
  set(0, 0, inputImage);

  // TODO: Fill in your code to implement the rest of TextRain here..

   for(int i=0; i<height;i++){
     for(int j=0; j<width;j++){
      flippedImage.pixels[j+i*width]=inputImage.pixels[width-1-j+i*width];
    }
  }

  flippedImage.loadPixels();

  for(int i=0; i<height;i++){
     for(int j=0; j<width;j++){
       color x=flippedImage.pixels[j+i*width];
      c[j+i*width]=thresholdPixel(x);
      if(debugGfx==1){
      flippedImage.pixels[j+i*width]=thresholdPixel(x);
      }
    }
  }
  
   flippedImage.updatePixels();
  
   set(0, 0, flippedImage);
    

    if(gap==20){
     
     if(fall[counter]==false){
     fall[counter]=true;  
     }
     gap=0;
     if(counter==numOfChar-1){
      counter=0;
      
     }else{
     counter++;
     }
    }
    
    
    update(1/frameRate);
   
  gap++;
  
 // println(threshold);
  
}

color thresholdPixel(color inputPixel) {
  color thresholdedColor;
  float brightness=brightness(inputPixel); 
  
  if(brightness<threshold){
   thresholdedColor = color(0);
  }else{
   thresholdedColor = color(255);
  }
  
  return thresholdedColor;
}


void update(float dt){
   for(int i=0; i<numOfChar; i++){
     if(fall[i]==true){
       
       if(c[int(x[i])+int(y[i])*(inputImage.width)]==color(255)){
           vel[i]+=gravity*dt;
           y[i]+=vel[i]*dt;
       }else{
        
         while(c[int(x[i])+int(y[i])*inputImage.width]==color(0)&&(y[i]>0)){
           y[i]-=1;
         }
         vel[i]=50;
       }
       fill(charC[i]);
       text(array[i],x[i],y[i]);
     }
       
    if(y[i]>=720){
      fall[i]=false;
      y[i]=0;
      x[i]=int(random(20,1260)); 
      vel[i]=0;
    }
   }
 
}




void keyPressed() {
  if (!inputMethodSelected) {
    
    // If we haven't yet selected the input method, then check for 0 to 9 keypresses to select from the input menu
    if ((key >= '0') && (key <= '9')) { 
      int input = key - '0';
      if (input == 0) {
        println("Offline mode selected.");
        mov = new Movie(this, "TextRainInput.mov");
        mov.loop();
        inputMethodSelected = true;
      }
      else if ((input >= 1) && (input <= 9)) {
        println("Camera " + input + " selected.");
        
        // The camera can be initialized directly using an element from the array returned by list():
        cam = new Capture(this, cameras[input-1]);
        cam.start();
        inputMethodSelected = true;
      }
    }
    return;
  }

  // This part of the keyPressed routine gets called after the input selection screen during normal execution of the program
  // TODO: Fill in your code to handle keypresses here..
  if (key == CODED) {
    if (keyCode == UP) {
      threshold=min(threshold+1,255.0);// up arrow key pressed
    }
    else if (keyCode == DOWN) {
      threshold=max(threshold-1,0.0);// down arrow key pressed
    }
  }
  else if (key == ' ') {
    if(debugGfx==0){
     debugGfx=1;
     }else{
     debugGfx=0;
     }// spacebar pressed
  } 
}
