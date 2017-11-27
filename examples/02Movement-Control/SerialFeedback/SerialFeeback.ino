/*
  Serial Feedback 
  Example for feeding back bytes received from the serial RXD pin  
  to the serial TXD pin
 */

void setup() {
  Serial.begin(9600);
}
 
void loop() {                                                                                                                                                                                                                                                                                                                                                                                                                                 
  while (Serial.available()>0){ //Whilst there is a serial connection, 
  Serial.print(char(Serial.read())); //Print the serial data back to the serial output as characters.
  }
}
