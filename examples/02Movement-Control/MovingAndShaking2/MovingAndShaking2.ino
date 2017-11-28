/*********************************************

MovingAndShaking2

This sketch builds on MovingAndShaking1 and speed modes as 
well as basic load-balancing variables
See (https://github.com/pi-bot/pioneers/wiki/Moving-and-Shaking)

Copyright:  Agilic Ltd
Nov. 20, 2017

Copy and alter for non-profit and learning
********************************************/
#include <PBmotorDriver.h> //Inc. lib to use its functions

PBmotorDriver  motors; // Create an instance of the motors 

// Set core variables:

//set tweek factors: reduce one side untill the speeds more or less balance.
int LMtweakFactor = 100;
int RMtweakFactor = 100;

//set speed mode power factors: 100 is 100% power
Int P4 = 100
int P3 = 75
int P2 = 50 
int P1 = 25

//set moevemnt keys
#define MOVE_LEFT 'a'
#define MOVE_RIGHT 'd'
#define MOVE_FORWARD 'w'
#define MOVE_BACK 'x'
#define FULL_STOP 's'
//set speed mode keys
#define MODE_1 '1'
#define MODE_2 '2'
#define MODE_3 '3'
#define MODE_4 '4'

void setup() {
  Serial.begin(9600); 
  delay (1000);
  Serial.println("Move the robot with the following keys: \n");
  Serial.println(" x:backward\n a:left\n d:right \n s:stop\n");
  Serial.println("Adjust the speed as follows: \n");
  Serial.println(" 1:25% power \n 2:50% power (default)\n 3:75% power \n 4:100% power\n");
  Serial.println("Press 'return' between each command \n \n");

}

void loop()
{

int power_factor = P2; // set the power factor to the default of speed 2
int LMpower = (FULL_POWER*power_factor*LMtweakFactor)/1000;
int RMpower = (FULL_POWER*power_factor*RMtweakFactor)/1000;

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
      Serial.println("movement stoped \n");
      byte = 0;
    }
    
        // press for speed 1
    if (byte == MODE_1) {
      if (power_factor != P1) {
            power_factor = P1;
            Serial.println(" Moving to Speed 1 \n");
      }
      byte = 0;
    }
    
        // press for speed 2
    if (byte == MODE_2) {
      if (power_factor != P2) {
            power_factor = P2;
            Serial.println(" Moving to Speed 2 \n");
      }
      byte = 0;
    }   
   
        // press for speed 3
    if (byte == MODE_3) {
      if (power_factor != P3) {
            power_factor = P3;
            Serial.println(" Moving to Speed 3 \n");
      }
      byte = 0;
    }   
    
      // press for speed 4
    if (byte == MODE_4) {
      if (power_factor != P4) {
            power_factor = P4;
            Serial.println(" Moving to Speed 4 \n");
      }
      byte = 0;
    }   
    
  }
  
  Serial.println("Have quit the interactive movement loop \n");
  Serial.end();
}
