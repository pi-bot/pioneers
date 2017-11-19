/*
Uses the new ping library from: http://playground.arduino.cc/Code/NewPing
*/
#include <NewPing.h>
 
#define TRIGGER_PIN  14
#define ECHO_PIN     17
#define MAX_DISTANCE 200
 
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
 
void setup() {
  Serial.begin(115200);
}
 
void loop() {
  delay(50);
  Serial.print("Ping: ");
  Serial.print(sonar.ping_cm());
  Serial.println("cm");
}
