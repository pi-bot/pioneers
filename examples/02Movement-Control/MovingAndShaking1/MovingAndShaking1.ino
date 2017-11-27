#include <PBmotorDriver.h>

/**
* Copyright:  Agilic Ltd
* Noc. 20, 2017
* This code is allowed to be altered and used 
* for non-profit purposes by hobbyists and is
* intended to remain free for all to share.
*/


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
  delay (1000);
  Serial.println("Move the robot with the following keys: \n");
  Serial.println(" x:backward\n a:left\n d:right \n s:stop\n");
  Serial.println("Press 'return' between each command \n \n");

}

void loop()
{
  char byte = 0;
  // press q to cancel and exit
  while (byte != 'q') {
    Serial.readBytes(&byte, 1);
    // press w to move forward
    if (byte == MOVE_FORWARD) {
    motors.setPwrs(LMpower, RMpower);
      Serial.println("moving forward \n");
      byte = 0;
    }
    // press x to move backward
    if (byte == MOVE_BACK) {
      motors.setPwrs(-LMpower, -RMpower);
      Serial.println("moving back \n");
      byte = 0;
    }
    // press a to turn left
    if (byte == MOVE_LEFT) {
      motors.stopRM();
      motors.setLMpwr(LMpower); 
      Serial.println("moving left \n");
      byte = 0;
    }
    // press d to turn right
    if (byte == MOVE_RIGHT) {
      motors.stopLM();
      motors.setRMpwr(LMpower); 
      Serial.println("moving right \n");
      byte = 0;
    }
    // press s to default stop
    if (byte == FULL_STOP) {
      motors.stopM();
      Serial.println("full stop \n");
      byte = 0;
    }
  }
  
  Serial.println("Have quit the interactive movement loop \n");
  Serial.end();
}
