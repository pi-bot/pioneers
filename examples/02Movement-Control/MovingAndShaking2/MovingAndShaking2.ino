/*********************************************

MovingAndShaking2

This sketch builds on MovingAndShaking1 and adds speed modes as 
well as basic load-balancing variables
See (https://github.com/pi-bot/pioneers/wiki/Moving-and-Shaking)

Copyright:  Agilic Ltd
Nov. 20, 2017

Copy and alter for non-profit and learning :)

N.B. there is alot of repeated code so using functions would 
improve this!
********************************************/
#include <PBmotorDriver.h> //Inc. lib to use its functions

PBmotorDriver  motors; // Create an instance of the motors 

// Set core variables:

//set tweek factors: reduce one side untill the speeds more or less balance.
const int LMtweakFactor = 100;
const int RMtweakFactor = 100;

//set speed mode power factors: 100 is 100% power
const int P4 = 100;
const int P3 = 75;
const int P2 = 50; 
const int P1 = 25;

//define the full power value
const int FULL_POWER = 255;

//set speed mode keys
const char MODE_1='1';
const char MODE_2='2';
const char MODE_3='3';
const char MODE_4='4';


//set movement keys
#define MOVE_LEFT 'a'
#define MOVE_RIGHT 'd'
#define MOVE_FORWARD 'w'
#define MOVE_BACK 'x'
#define FULL_STOP 's'


void setup() {
  Serial.begin(9600); 
  delay (2000);
  Serial.println("Move the robot with the following keys: \n");
  Serial.println(" x:backward\n a:left\n d:right \n s:stop\n");
  Serial.println("Adjust the speed as follows: \n");
  Serial.println(" 1:25% power \n 2:50% power (default)\n 3:75% power \n 4:100% power\n");
  Serial.println("Press 'return' between each command \n \n");

}

void loop()
{

static int power_factor = P2; // set the power factor to the default of speed 2

int LMpowerFull = FULL_POWER*LMtweakFactor/100; // This is the reference for changes to LMpower through the speed mode selections 
int RMpowerFull = FULL_POWER*RMtweakFactor/100; // This is the reference for changes to LMpower through the speed mode selections 


static int LMpower = FULL_POWER*LMtweakFactor/100; //Declare the LMpower value 
static int RMpower = FULL_POWER*RMtweakFactor/100; //Declare the LMpower value

LMpower = LMpower*power_factor/100;//Adjust in respect of the default  power factor 
RMpower = RMpower*power_factor/100;//Adjust in respect of the default  power factor 


  char byte = 0;
  // press q to cancel and exit
  while (byte != 'q') {
    Serial.readBytes(&byte, 1);
    // press w to move forward  
    if (byte == MOVE_FORWARD) {   //when the move foreward key is pressed use the PMmotorDriver functions 
      motors.setPwrs(LMpower, RMpower);
      Serial.print("\n Moving forward with left and right power:");
      Serial.print(-LMpower);Serial.print(":"); Serial.print(-RMpower);   
      byte = 0;
    }
    // press x to move backward
    if (byte == MOVE_BACK) {
      motors.setPwrs(-LMpower, -RMpower);
      Serial.print("\n Moving back with left and right power:");
      Serial.print(-LMpower);Serial.print(":"); Serial.print(-RMpower); 
      byte = 0;
    }
    // press a to turn left
    if (byte == MOVE_LEFT) {
      motors.stopRM();
      motors.setLMpwr(LMpower); 
      Serial.print("\n Moving left with Left Motor power of: ");
      Serial.print(LMpower);
      byte = 0;
    }
    // press d to turn right
    if (byte == MOVE_RIGHT) {
      motors.stopLM();
      motors.setRMpwr(RMpower); 
      Serial.print("\n Moving right with Left Motor power of: ");
      Serial.print(RMpower);
      byte = 0;
    }
    // press s to default stop
    if (byte == FULL_STOP) {
      motors.stopM();
      Serial.println("\n Movement stopped \n");
      byte = 0;
    }


          // press for speed 1
    if (byte == MODE_1) {
      if (power_factor != P1) {  //check that the power_factor is different to existing before changing it
            power_factor = P1;
            LMpower = LMpowerFull*power_factor/100;
            RMpower = RMpowerFull*power_factor/100;
            Serial.print("\n Moving to Speed 1, with a power factor of:");Serial.print(power_factor);
            Serial.print("\n The Left and Right power values are now:");
            Serial.print(LMpower);Serial.print(":");Serial.print(RMpower);           
      }
      byte = 0;
    }
   
        // press for speed 2
    if (byte == MODE_2) {
      if (power_factor != P2) {
            power_factor = P2;
            LMpower = LMpowerFull*power_factor/100;
            RMpower = RMpowerFull*power_factor/100;           
            Serial.print("\n Moving to Speed 2, with a power factor of:");Serial.print(power_factor);
            Serial.print("\n The Left and Right power values are now:");
            Serial.print(LMpower);Serial.print(":");Serial.print(RMpower);           
      }
      byte = 0;
    }   
   
        // press for speed 3
    if (byte == MODE_3) {
      if (power_factor != P3) {
            power_factor = P3;
            LMpower = LMpowerFull*power_factor/100;
            RMpower = RMpowerFull*power_factor/100;           
            Serial.print("\n Moving to Speed 3, with a power factor of:");Serial.print(power_factor);
            Serial.print("\n The Left and Right power values are now:");
            Serial.print(LMpower);Serial.print(":");Serial.print(RMpower);           
      }
      byte = 0;
    }   
    
      // press for speed 4
    if (byte == MODE_4) {
      if (power_factor != P4) {
            power_factor = P4;
            LMpower = LMpowerFull*power_factor/100;
            RMpower = RMpowerFull*power_factor/100;
            Serial.print("\n Moving to Speed 4, with a power factor of:");Serial.print(power_factor);   
            Serial.print("\n The Left and Right power values are now:");
            Serial.print(LMpower);Serial.print(":");Serial.print(RMpower); 
                    
      }
      byte = 0;
    }   
 
  }
  
  Serial.println("Have quit the interactive movement loop \n");
  Serial.end();

}
