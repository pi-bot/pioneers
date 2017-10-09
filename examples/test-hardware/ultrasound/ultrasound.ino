#include "Arduino.h"

int trigPin = 14;    //Trig - green Jumper
int echoPin = 14;    //Echo - yellow Jumper
long duration, cm, inches;

void setup() {
   Serial.begin(9600);
   int readUltrasound(int triggerPin)
{
  pinMode(triggerPin, OUTPUT);
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(4);
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin, LOW);
  pinMode(triggerPin, INPUT);
  long duration = pulseIn(triggerPin, HIGH, 100000);//0.1 second of timeout
  long distance = (duration/2) / 29.1; //distance in cm
  return distance;
};
    
}

void loop()
{
   unsigned int uS =readUltrasound(trigPin);
   Serial.print(uS);
     delay(250);
  }
