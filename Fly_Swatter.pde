//Images 
PImage fly,flybye,swatter,swatted;

//fly locations
float[] fX,fY; 

//Checking if fly has been swatted or not
float[] swat;  

//score feature
int score=0;

//Setup declares arrays and screen size
void setup() {
  size(800,600);
  fX=new float[0];
  fY=new float[0];
  swat=new float[0];
  
  // load and resize images
  fly = loadImage("fly.png") ;
  fly.resize(80,80);  
  flybye = loadImage("flybye.png") ;
  flybye.resize(100,100);
  swatter = loadImage("swatter.png") ;
  swatted = loadImage("swatted.png") ;
  
  //first fly - random location
  fX =append(fX,random(width-fly.width)); 
  fY =append(fY,random(height-fly.height));
  
  swat = append(swat,0); //appending swat array
}

void draw(){ 
  background(255);
  populate();
  fill(0);
  
  if(mousePressed) { // image swap
      collisionDetect();
      image(swatted,mouseX-35,mouseY-25);    
    } 
    else {
      image(swatter,mouseX-35,mouseY-25); // if not pressed then alternative image.
    }           
  fill(0);                         
  text("SCORE: " + score,10,40);   // Offset Y by 5 greater than Text Size.
}



void populate() {
  for(int i=0; i<fX.length; i++)
  {
    if(swat[i]==1) {
      // resize the fly image and place based on fx/fy array values      
      image(flybye,fX[i],fY[i]);
    } 
    else { // not swatted
      image(fly,fX[i],fY[i]);
    }
  }
}

//Collision detection for fly and swatter
void collisionDetect() {
  for(int i=0; i<swat.length;i++) {
    if((mouseX >= fX[i] & mouseX <= fX[i]+fly.width) &
      (mouseY >= fY[i] & mouseY <= fY[i]+fly.height)) { 
        swat[i] = 1; // swatted as within bounding box
          
          //new fly placed in random location when old fly dies.
          if(swat[swat.length-1] != 0) {
              fX =append(fX,random(width-fly.width)); 
              fY =append(fY,random(height-fly.height));        
              swat = append(swat,0); // new fly not swatted
              score++; //increment score
          }
      }
  }
}
