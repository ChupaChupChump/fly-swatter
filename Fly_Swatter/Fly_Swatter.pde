/* Fly Swatter program by Mitchell charity
a fun fly swatting game.

To compile the program using processing.
  In processing.
    file -> export applications -> select OS
    If you have java installed uncheck "embedded java to save space"
    
  To run the program:
    enter the folder that was created after exporting
    open Fly_swatter applications and enjoy
*/

//Images 
PImage fly, flybye, swatter, swatted;

//Slap sound https://www.freesoundeffects.com/free-track/slap-426860/
//Using processing sound library
import processing.sound.*;
SoundFile slap;

//fly locations
float[] fX, fY; 

//Checking if fly has been swatted or not
float[] swat;  

//score feature
int score=0;

void setup() { //Setup declares arrays and screen size
  size(800, 600);
  fX=new float[0];
  fY=new float[0];
  swat=new float[0];

  // initialise slap sound
  slap = new SoundFile(this, "slap.mp3");

  // load and resize images
  fly = loadImage("fly.png") ;
  fly.resize(80, 80);  
  flybye = loadImage("flybye.png") ;
  flybye.resize(100, 100);
  swatter = loadImage("swatter.png") ;
  swatted = loadImage("swatted.png") ;

  //first fly - random location
  fX =append(fX, random(width-fly.width)); 
  fY =append(fY, random(height-fly.height));

  //appending swat array
  swat = append(swat, 0);
}

void draw() { 
  background(255);
  populate();
  fill(0);

  if (mousePressed) { // image swap
    slap.play();
    collisionDetect();
    image(swatted, mouseX-35, mouseY-25);
    delay(100); //temporary fix for holding mouse down sound bug
  } else { // if not pressed then alternative image.
    image(swatter, mouseX-35, mouseY-25);
  }    

  text("SCORE: " + score, width/2, 40);
  textSize(24);
  textAlign(CENTER);

  hiscores();
}

void hiscores() { //Scoring additional functions aand graphics
  if (score == 5) {
    text("PENTAKILL", width/2, height/2);
    textAlign(CENTER);
  }
  if (score == 10) {
    text("SWATTING SPREE", width/2, height/2);
    textAlign(CENTER);
  }
  if (score == 30) {
    text("swatting frenzy", width/2, height/2);
    textAlign(CENTER);
  }
  if (score == 50) {
    text("EXTERMINATOR", width/2, height/2);
    textAlign(CENTER);
  }
  if (score == 100) {
    text("TERMINATOR", width/2, height/2);
    textAlign(CENTER);
  }
}

void flyMovement() { //TODO fly movement
}


// Populates the screen with fly
void populate() {
  for (int i=0; i<fX.length; i++)
  {
    if (swat[i]==1) {

      // resize the fly image and place based on fx/fy array values      
      image(flybye, fX[i], fY[i]);
    } else { // not swatted
      image(fly, fX[i], fY[i]);
    }
  }
}

void collisionDetect() { //Collision detection for fly and swatter
  for (int i=0; i<swat.length; i++) {
    if ((mouseX >= fX[i] & mouseX <= fX[i]+fly.width) &
      (mouseY >= fY[i] & mouseY <= fY[i]+fly.height)) { 
      swat[i] = 1; // swatted as within bounding box

      //new fly placed in random location when old fly dies.
      if (swat[swat.length-1] != 0) {
        fX =append(fX, random(width-fly.width)); 
        fY =append(fY, random(height-fly.height));        
        swat = append(swat, 0); // new fly not swatted
        score++; //increment score
      }
    }
  }
}
