//Cameron Kuwada

#include <MeggyJrSimple.h>   

struct Point
{
  int x;
  int y;
};



Point s1 = {3,4};
Point s2 = {4,4};
Point s3 = {5,4};
Point s4 = {7,4};



Point snakeArray[64] = {s1, s2, s3, s4};  //snake body points

Point apple = {random(8),random(8)};   //Coordinates for apple at random location.

int direction = 0; //different values account for the change in direction of snake

int speed = 250; //Variable for delay. Increasing/Decreasing variable changes speed of snake

int score = 0;  //Accounts for the lights going up, every time you collect an apple.

int marker = 4; //the empty slot for the array.

void setup()                    
{
  MeggyJrSimpleSetup();   
  Serial.begin(9600);
}


void drawSnake()
{
  for (int i = 0; i < marker; i++)
  {
    DrawPx(snakeArray[i].x, snakeArray[i].y,Green);
  }
  DrawPx(snakeArray[0].x, snakeArray[0].y, Green);
}

void updateSnake()
{
  for (int i = marker-1; i > 0; i--)
  {
    snakeArray[i] = snakeArray[i-1];
  }
}


void loop()                     
{
  drawSnake();
  DrawPx(apple.x, apple.y, Red);
  DisplaySlate();
  delay(speed);
  ClearSlate();
  updateSnake();
  
  CheckButtonsPress();
 
  if (Button_Up)
  
  direction = 0;  

  if (Button_Right)
  
  direction = 90;  

  if (Button_Down)
  
  direction = 180; 
  
  if (Button_Left)
  
   direction = 270;   
  
  if (Button_A)
  
    speed=speed+100;
    
  if (Button_B)
    
    speed=speed-100;
  
  if (direction == 0)
 
    snakeArray[0].y++;
  
  if (direction == 90)
  
    snakeArray[0].x++;
  
  if (direction == 180)
  
    snakeArray[0].y--;
  
  if (direction == 270)
  
    snakeArray[0].x--;
  
  //Controls movement of snake
  
  if (snakeArray[0].x > 7)
  
    snakeArray[0].x=0;
  
  if (snakeArray[0].x<0)
  
    snakeArray[0].x=7;
  
  if (snakeArray[0].y >7)
  
    snakeArray[0].y=0;
  
  if (snakeArray[0].y<0)
  
    snakeArray[0].y=7;
  
  //so snake can move continously through area.
 
  DrawPx(apple.x, apple.y, Red);
  if (ReadPx(snakeArray[0].x,snakeArray[0].y) == Red)   //Lets program know that Snake has hit the apple
{
  Serial.println("Resetting apple...");
  apple.x = random(8);
  apple.y = random(8);
  DisplaySlate();
  marker++;
  score++; 
  Tone_Start(ToneG3,70);
}

if (score == 1)               //lights up one light when snake gets apple
 SetAuxLEDsBinary(B10000000);
if (score == 2)
 SetAuxLEDsBinary(B11000000);
if (score == 3)
 SetAuxLEDsBinary(B11100000);
if (score == 4)
 SetAuxLEDsBinary(B11110000);
if (score == 5)
 SetAuxLEDsBinary(B11111000);
if (score == 6)
 SetAuxLEDsBinary(B11111100);
if (score == 7)
 SetAuxLEDsBinary(B11111110);
if (score == 8)
 SetAuxLEDsBinary(B11111111);

if (score == 8)

{                                    //End of the game animation/ sound alert.
for (int o = 0; o <8; o++)
 {
  for (int p = 0; p < 8; p++)
 
DrawPx(o,p,random(8)+1);
DisplaySlate();
Tone_Start(ToneE4, 100);
Tone_Start(ToneGs4, 100);
Tone_Start(ToneB4, 100);
Tone_Start(ToneE5, 1000);
ClearSlate();
delay(500);
score = 0;  //Resets Game
marker =4;
}
}
}




