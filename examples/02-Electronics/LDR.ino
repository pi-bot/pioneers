/*
  Copied and Modified from https://www.tweaking4all.com/hardware/arduino/arduino-light-sensitive-resistor/
  Captures a value of an LDR and uses it to detect a 'low-light' level from which to light an LED.
  circuit:
  - LED connected to Analog pin in series with a resistor.
*/


#define LDRpin A0 // pin where we connected the LDR and the resistor

int LDRValue = 0;     // result of reading the analog pin

void setup() {
  Serial.begin(9600); // sets serial port for communication
}

void loop() {
  LDRValue = analogRead(LDRpin); // read the value from the LDR
  Serial.println(LDRValue);      // print the value to the serial port
  delay(100);                    // wait a little
}
