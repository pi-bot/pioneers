/* Flashlight Following Robot Code 3/25/2014
From http://www.instructables.com/id/Arduino-Flashlight-Following-Robot/
N.B. This example requires extra hardware. Included as an interesting follow on project.
This code uses three light dependent resistors positioned
on the right, front and left sides of a robot to control
motion. When light of sufficient strength falls on one of
the sensors, the robot turns right, moves forward or turns
left.
*/

// Motor control pins
int E1 = 5; // Enable pin for right motor
int M1 = 4; // Speed control pin for left motor
int E2 = 6; // Enable pin for the left motor
int M2 = 7; // Speed control pin for right motor

// The following motor speeds are determined by experiment
// so that the robot moves forward in a straight line.
int leftMotorSpeed = 215;
int rightMotorSpeed = 185;

int sensorPinRight = 0; // Right sensor pin
int sensorPinCenter = 1; // Center sensor pin
int sensorPinLeft = 2; // Left sensor pin

int lightReadingRight;
int lightToleranceRight = 1000; // Sensor reading needed to trigger right turn

int lightReadingCenter;
int lightToleranceCenter = 1000; // Sensor reading needed to trigger forward movement

int lightReadingLeft;
int lightToleranceLeft = 1000; // Sensor reading needed to trigger left turn

int readingDelay = 100; // Delay between readings

void setup()
{
pinMode(M1,OUTPUT);
pinMode(M2,OUTPUT);

// Uncomment the serial feed for calibration purposes
Serial.begin(9600);
}

void loop()
{
// Uncomment the serial print lines for calibration purposes

// Take reading from right sensor
lightReadingRight = analogRead(sensorPinRight);
Serial.print("Right Sensor Reading :");
Serial.println(lightReadingRight);

// Take reading from center sensor
lightReadingCenter = analogRead(sensorPinCenter);
Serial.print("Center Sensor Reading :");
Serial.println(lightReadingCenter);

// Take reading from left sensor
lightReadingLeft = analogRead(sensorPinLeft);
Serial.print("Left Sensor Reading :");
Serial.println(lightReadingLeft);


// Move forward if enought light is detected from center sensor
if (lightReadingCenter > lightToleranceCenter)
{
digitalWrite(M1, HIGH); 
digitalWrite(M2, HIGH); 
analogWrite(E1, leftMotorSpeed); 
analogWrite(E2, rightMotorSpeed);
delay(readingDelay);
// Stop
digitalWrite(M1, LOW);
digitalWrite(M2, LOW);
analogWrite(E1, 0); 
analogWrite(E2, 0);
}

// Turn right if enough light is detected from right sensor
if (lightReadingRight > lightToleranceRight)
{
digitalWrite(M1, LOW); 
digitalWrite(M2, HIGH); 
analogWrite(E1, leftMotorSpeed); 
analogWrite(E2, rightMotorSpeed);
delay(readingDelay);
// Stop
digitalWrite(M1, LOW);
digitalWrite(M2, LOW);
analogWrite(E1, 0); 
analogWrite(E2, 0);
}

// Turn left if enough light is detected from left sensor
if (lightReadingLeft > lightToleranceLeft)
{
digitalWrite(M1, HIGH); 
digitalWrite(M2, LOW); 
analogWrite(E1, leftMotorSpeed); 
analogWrite(E2, rightMotorSpeed);
delay(readingDelay);
// Stop
digitalWrite(M1, LOW);
digitalWrite(M2, LOW);
analogWrite(E1, 0); 
analogWrite(E2, 0);
}
// delay(5000); // Uncomment this long delay for motor calibration purposes
}
