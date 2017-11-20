// 2-Servo Arduino Robotic Car
// Copyright:  Tolson Winters
// Feb. 20, 2014
// This code is allowed to be altered and used 
// for non-profit purposes by hobbyists and is
// intended to remain free for all to share.

#include <Servo.h>
// Create two servo instances
Servo back_left_servo;
Servo back_right_servo;
// Sending signals to servos:
// 90 is no servo movement (mid-point)
// 0 is full speed forward
// 180 is full speed backward
int back_left_speed = 90;
int back_right_speed = 90;
#define MOVE_FORWARD 'w'
#define MOVE_BACK 's'
#define MOVE_LEFT 'a'
#define MOVE_RIGHT 'd'
#define FULL_STOP 'e'
// not all servos stop at exactly 90, so adjust default stop here
#define LEFT_DEFAULT_STOP 90  
#define RIGHT_DEFAULT_STOP 89
void setup() {
  Serial.begin(9600); 
  // Attach the servos on Arduino PWM pin 3 and PWM pin 5
  back_left_servo.attach(5);
  back_right_servo.attach(6);
  // Set servos to mid-range, ie, default stop
  back_left_servo.write(LEFT_DEFAULT_STOP);
  back_right_servo.write(RIGHT_DEFAULT_STOP);
}

void loop(){
  char byte = 0;
  // press q to cancel and exit
  while (byte != 'q') {
    Serial.readBytes(&byte, 1);
    // press w to move forward
    if (byte == MOVE_FORWARD) {
      back_left_speed = back_left_servo.read();
      back_left_speed -= 5;  // Increase speed by 5
      back_left_servo.write(back_left_speed);

      back_right_speed = back_right_servo.read();
      back_right_speed += 5;  // Increase speed by 5
      back_right_servo.write(back_right_speed);
      Serial.println("move forward \n");
      byte = 0;
    }
    // press s to move backward
    if (byte == MOVE_BACK) {
      back_left_speed = back_left_servo.read();
      back_left_speed += 5;  // Decrease speed by 5
      back_left_servo.write(back_left_speed);
      
      back_right_speed = back_right_servo.read();
      back_right_speed -= 5;  // Decrease speed by 5
      back_right_servo.write(back_right_speed);
      Serial.println("move back \n");
      byte = 0;
    }
    // press a to turn left
    if (byte == MOVE_LEFT) {
      back_left_speed = back_left_servo.read();
      back_left_speed += 5;  // Decrease speed by 5
      back_left_servo.write(back_left_speed);

      back_right_speed = back_right_servo.read();
      back_right_speed += 5;  // Increase speed by 5
      back_right_servo.write(back_right_speed);
      Serial.println("move left \n");
      byte = 0;
    }
    // press d to turn right
    if (byte == MOVE_RIGHT) {
      back_left_speed = back_left_servo.read();
      back_left_speed -= 5;  // Increase speed by 5
      back_left_servo.write(back_left_speed);

      back_right_speed = back_right_servo.read();
      back_right_speed -= 5;  // Decrease speed by 5
      back_right_servo.write(back_right_speed);
      Serial.println("move right \n");
      byte = 0;
    }
    // press e to default stop
    if (byte == FULL_STOP) {
      back_left_servo.write(LEFT_DEFAULT_STOP);
      back_right_servo.write(RIGHT_DEFAULT_STOP);
      Serial.println("full stop \n");
      byte = 0;
    }
  }
  
  Serial.println("Done \n");
  Serial.end();
}
