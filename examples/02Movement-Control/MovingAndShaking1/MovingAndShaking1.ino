/**
* Copyright:  Agilic Ltd
* Noc. 20, 2017
* This code is allowed to be altered and used 
* for non-profit purposes by hobbyists and is
* intended to remain free for all to share.
*/

#include <PBmotorDriver.h>
// Create an instance of the motors 
PBmotorDriver  motors;

// Set core variables:
// speed can be 0 to 255
// make adjustments to balance L and R speeds if needed 
int LMpower = 122;
int RMpower = 122;
#define MOVE_LEFT 'a'
#define MOVE_RIGHT 'd'
#define MOVE_FORWARD 'w'
#define MOVE_BACK 'x'
#define FULL_STOP 's'

void setup() {
  Serial.begin(9600); 
}

void loop()
{
  char byte = 0;
  // press q to cancel and exit
  while (byte != 'q') {
    Serial.readBytes(&byte, 1);
    // press w to move forward
    if (byte == MOVE_FORWARD) {
    setPwrs(LMpower, RMpower) 

      Serial.println("moving forward \n");
      byte = 0;
    }
    // press x to move backward
    if (byte == MOVE_BACK) {
      setPwrs(-LMpower, -RMpower) 
      Serial.println("move back \n");
      byte = 0;
    }
    // press a to turn left
    if (byte == MOVE_LEFT) {
      stopRM;
      setLMpwr(LMpower); 
      Serial.println("move left \n");
      byte = 0;
    }
    // press d to turn right
    if (byte == MOVE_RIGHT) {
      stopLM;
      setRMpwr(LMpower); 
      Serial.println("move right \n");
      byte = 0;
    }
    // press s to default stop
    if (byte == FULL_STOP) {
      back_left_servo.write(LEFT_DEFAULT_STOP);
      back_right_servo.write(RIGHT_DEFAULT_STOP);
      Serial.println("full stop \n");
      byte = 0;
    }
  }
  
  Serial.println("Have quit interactive movement loop \n");
  Serial.end();
}
