//Libraries Used
//Sound Library
import processing.sound.*;


//Interaction Events

//Right Key Reduces the balls X speed to 0 and as a result makes the ball go left or right dependent on its current direction
//Left Key reduces the ball Y speed to 0 and as a result makes the ball go left or right dependent on its current direction
//Up key increases the balls Speed by +10
//Down key decreases the balls speed by -10
//S key Stops the ball where it currently is
//Z key stops the creating the grid effect
//X key Re-enables the grid effect
//P Resets the environment,
//+ Add's 1 line to the ball
// - Removes 1 line from the ball
// 0 Removes all lines from the ball
// 1 Randomises the ball's color and the grids
// 2 Randomises the grids color
// 3 Randomises and changes the line color around the ball
// 4 Resets the line color to white
// 5 Randomises everything and everything changes 
// 6 Turns off randomiser
// 7 Randomly recreates the grid in a different size from 1-200, makes it lag a bit
// 9 Resets the ball back to its original 10 lines
// 8 Randomises the amount of lines around the circle from 0-255






// Global Varibless

//Varible which tracks and resets the background after 5 iterations
int LoopCounter = 0;

//-----------------------------------------------------

//Lines Around the Ball
//Diameter from the middle of the circle for the lines. Increasing spreads out more, decreasing creates them closer
int LineDiameter = 150;
//Amount of lines around the ball
int NumberOfLines = 10;
//Initial speed of the lines
float SpeedOfLines = 0.05;
//Calculating the angle of each line which is based off of the total amount of lines
float Angle = TWO_PI/NumberOfLines;
//Diamter of each line being calcuated, decreasing brings lines closer, increasing spreads them out
float RingOfLines = LineDiameter*.5;

//-----------------------------------------------------

//Ball
//Width of the shape
int Rad = 60;    
//Starting position of the ball
float Xpos, Ypos;

//Intial speed of the ball
float xspeed = 5.8;
//Intial speed of the ball
float yspeed = 5.8;

//Left or Right direction of the ball when it hits the left or right wall
int xdirection = 1;
//Top or Down diretion of the ball when it hits the top or bottom wall
int ydirection = 1;

//-----------------------------------------------

//Changing Color of the ball
float RandomColor1 = random(255);
float RandomColor2 = random(255);
float RandomColor3 = random(255);



// -------------------------------------------------

//Changing color of the grid
float RandomGridColor1 = random(255);
float RandomGridColor2 = random(255);
float RandomGridColor3 = random(255);

//--------------------------------------------------

//Setting the grid size intially of the white effect you see
float gridSize = 40;
boolean StopGrid = false;

//----------------------------------------------------
//Boolean value for changing line color on the ball
boolean WhiteLineColor = false;
float LineColor1;
float LineColor2;
float LineColor3;

//--------------------------------------------------------
//Boolean for Random Color Everything
boolean RandomAll = false;
float RandomVal1;
float RandomVal2;
float RandomVal3;
float RandomVal4;
float RandomVal5;
float RandomVal6;
float RandomVal7;
float RandomVal8;
float RandomVal9;
float RandomVal10;

//Varibles to change how fast the ball changes color in rapid color change mode
int wait = 1;
int reloadStartTime;



// Importing our mp3 file to let us use it in our program
SoundFile file;
String audioName = "doh.mp3";
String path;

//-------------------------------
//Ball Class variables

int numBalls = 102;
float spring = 0.05;
float gravity = 0.03;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];


void setup() 
{
  //Setting the size of the screen
  size(1280, 720);
  //Setting the background in setup lets us see the cool effect
  background(51);
  
  //Ball code adapted from https://processing.org/examples/bounce.html
  noStroke();
  //Setting the frame rate
  frameRate(30);
  //Setting the ellipse mode
  ellipseMode(RADIUS);
  // Set the starting position of the shape to be in the middle of the screen
  Xpos = width/2.0;
  Ypos = height/2.0;
  
  //Setting up the path to make sure it can run on anyones computer
  path = sketchPath(audioName);
  //Setting the file path to be the root directory where sketchPath made it
  file = new SoundFile(this, path);
  
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(30, 70), i, balls);
  }
    
}


void draw() 
{
  
  
  //Handles the random color changing
  if (millis() > reloadStartTime + wait)
  {
    RandomAllObs();
    reloadStartTime = millis();
  }
  
  BallnLine();
  
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();  
  }
    
}

void Reset()
{
  //Once the angle of the lines rotates over 100 change the ball color and grid size randomly
  if (Angle > 100)
  {
    ResetVariables();
  }
  //When the loop counter hits 5 reset the background and start again essentially
  else if (LoopCounter == 5)
  {
    ResetLoopCounter();
    
  }
  //Else create the grid of squares that is shown
  else
  {
    if (StopGrid == false)
    {
      CreateGrid();
    }
    
    if (keyPressed)
    {
      if (key == 'z')
      {
        StopGrid = true;
        
      }
      else if (key == 'x')
      {
        StopGrid = false;
      }
    }
    
    
  }
 

}


void CreateGrid()
{
  
  //Adapted code from https://processing.org/examples/embeddediteration.html 
  //Looping through to create a 2D array which provides us with the perfect square shape
  //As seen in the display
  for (float x = gridSize; x <= width - gridSize; x += gridSize) {
    for (float y = gridSize; y <= height - gridSize; y += gridSize) {
      //Calling no stroke to keep it clear and not to bulky from the previous stroke size
      noStroke();
      //Assigning the points/corners of each square a random color
      if (RandomAll == true)
      {
        fill(RandomVal7);
      }
      else
      {
        fill(RandomColor1);
      }
      //Creating the rectangle from the 2D array
      rect(x-1, y-1, 3, 3);
      //Setting the stroke size to make the ideal square
      if (RandomAll == true)
      {
        stroke(RandomVal8, RandomVal9, RandomVal10);
      }
      else
      {
        stroke(RandomGridColor1, RandomGridColor2, RandomGridColor3);
      }
      //Creating the lines between each rectangle to provide to the effect shown
      line(x, y, width/2, height/2);
      }
    }

}

void ResetVariables()
{
  //Resetting the intial varibles
    Angle = 0;
    xspeed = 5.8;
    yspeed = 5.8;
    SpeedOfLines = 0.05;
    //Changing the color of the ball randomly
    RandomColor1 = random(255);
    RandomColor2 = random(255);
    RandomColor3 = random(255);
    //Randomly choosing a grid size between 40 and 250
    gridSize = random(40,250);
    //Increasing the loop counter
    LoopCounter = LoopCounter + 1;
}

void ResetLoopCounter()
{
  //Reset the background
    background(51);
    //Recall the draw function to allow us to continuing the effect 
    draw();
    //Resetting the loop counter
    LoopCounter = 0;
}


void BallnLine()
{
  //We call nofill here because without it the grid effect is completely white and removes to much of the balls effect
  noFill();
  //Making sure the lines around the circle are clear and really seen to provide to the effect
  stroke(255);
  
  //Setting the boundaries of the screen
  Xpos = Xpos + ( xspeed * xdirection );
  Ypos = Ypos + ( yspeed * ydirection );
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (Xpos > width-Rad || Xpos < Rad) 
  {
    //Bouncing the ball off the wall
    xdirection *= -1;
    //Increasing the ball speed
    xspeed = xspeed + 2;
    yspeed = yspeed + 2;
    //Increasing the line rotation speed
    SpeedOfLines = SpeedOfLines + 0.015;
    //Play the sound
    file.play();
      
  }
  //If the ball exceeds the boundaries of the screen send it in reverse
  if (Ypos > height-Rad || Ypos < Rad) 
  {
    //Bouncing the ball of the wall
    ydirection *= -1;
    //Increasing the ball speed
    xspeed = xspeed + 2;
    yspeed = yspeed + 2;
    //Increasing the line rotation speed
    SpeedOfLines = SpeedOfLines + 0.015;
    //Play the sound
    file.play();
       
  }

  // Drawing the circle
  beginShape();
  //Setting it to be a random color
  if (RandomAll == true)
  {
    fill(RandomVal4,RandomVal5,RandomVal6);
  }
  else
  {
    fill(RandomColor1,RandomColor2,RandomColor3);
  }
  
  //Creating the ball itself
  ellipse(Xpos, Ypos, Rad, Rad);
  endShape();
  noFill();
  //Setting all objects to be centred around the ball. This is important as it ensures we can create the cool effect on the screen
  translate(Xpos,Ypos);
 
  //Looping through each line and creating each line until we reach the maximum amount of lines
  for (int i = 0; i < NumberOfLines; i++) 
  {
    //Pushing the start of the matrix stack to let us to add a new line
    pushMatrix();
    //Creating the angle at which each line is at
    rotate(Angle +i*TWO_PI/NumberOfLines);
    //Creating the line at that postiton
    if (WhiteLineColor == true)
    {
      stroke(255,255,255);
    }
    else if (RandomAll == true)
    {
      stroke(RandomVal1,RandomVal2,RandomVal3);
    
    }
    else
    {
      stroke(LineColor1,LineColor2,LineColor3);
      
    }
    line(RingOfLines, 0, RingOfLines + 40, 0);
    popMatrix();
  }
  //Setting the angle rotation speed and increasing it
  Angle += SpeedOfLines;
  
  //Calling our reset function
  Reset();
  
}

//Function to randomise all values
void RandomAllObs()
{
  //If random mode is activated make everything random
  if (RandomAll == true)
  {
    RandomVal1 = random(255);
    RandomVal2 = random(255);
    RandomVal3 = random(255);
    RandomVal4 = random(255);
    RandomVal5 = random(255);
    RandomVal6 = random(255);
    RandomVal7 = random(255);
    RandomVal8 = random(255);
    RandomVal9 = random(255);
    RandomVal10 = random(255); 
    
    
  }

}


//Key press input events
void keyPressed()
{
  //If down on keypad, slow the ball
  if (keyCode == DOWN)
  {
    xspeed = xspeed - 10;
    yspeed = yspeed - 10;
    
  }
  
  //If up on key pad, increase speed
  else if (keyCode == UP)
  {
    xspeed = xspeed + 10;
    yspeed = yspeed + 10;
    
  }
  
  //Stop the ball in the Y direction making it go straight in a direction
  else if (keyCode == LEFT)
  {
    yspeed = 0;
  }
  
  //Stop the ball in X direction making it go straight in a direction
  else if (keyCode == RIGHT)
  {
    xspeed = 0;
  }
  
  //If press s, stop the ball completely
  else if (key =='s')
  {
    xspeed = 0;
    yspeed = 0;
  }
  
  //If press P reset everything
  else if (key == 'p')
  {
    Xpos = 640;
    Ypos = 360;
    ResetLoopCounter();
    ResetVariables();
  }
  
  //Increases the line the ball has
  else if (key == '+')
  {
    NumberOfLines = NumberOfLines + 1;
  }
  
  //Decreases the line the ball has
  else if (key == '-')
  {
    NumberOfLines = NumberOfLines - 1;
  }
  
  //Gets rid of all the lines on the ball
  else if (key == '0')
  {
    NumberOfLines = 0;
  }
  
  //Randomise the color of the ball and grid points
  else if (key == '1')
  {
    RandomColor1 = random(255);
    RandomColor2 = random(255);
    RandomColor3 = random(255);
  }
  
  //Randomise the grids color
  else if (key == '2')
  {
    RandomGridColor1 = random(255);
    RandomGridColor2 = random(255);
    RandomGridColor3 = random(255);
  }
  
  //Randomise the line color on the ball
  else if (key == '3')
  {
    LineColor1 = random(255);
    LineColor2 = random(255);
    LineColor3 = random(255);
    WhiteLineColor = false;
  }
  
  //Make the balls color white
  else if (key == '4')
  {
    WhiteLineColor = true;
  }
  //Activate random mode
  else if (key == '5')
  {
    RandomAll = true;
    RandomAllObs();
  
  }
  //get rid of random mode
  else if (key == '6')
  {
    RandomAll = false;
  }
  
  //Create a new grid of a different size, this is cool to watch
  else if (key == '7')
  {
    float NewGridSize = random(200);
    gridSize = int(NewGridSize);
    
  }
  //Gives the ball a random number of lines
  else if (key == '8')
  {
    float NumberOfLinesFloat = random(255);
    NumberOfLines = int(NumberOfLinesFloat);
  }
  
  //Gives the ball 10 lines
  else if (key == '9')
  {
    NumberOfLines = 10;
  }
  
  
}


void mousePressed()
{
  //If mouse is over the ball and pressed
  if (mouseY > Ypos-Rad && mouseY < Ypos+Rad && mouseX > Xpos-Rad && mouseX < Xpos+Rad)
  {
    //Make it go crazy
    RandomAll = true;
    xspeed = xspeed + 100;
    yspeed = yspeed + 100;
    
  }

}



class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
