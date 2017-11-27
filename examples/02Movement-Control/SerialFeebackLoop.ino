void setup() {
  Serial.begin(9600);
}
 
void loop() {
while (Serial.available()>0) serIn=Serial.read(); //Whilst there is a serial connection, read the serial data in to serIn variable.
Serial.print(serIn); //Print the serial data back to MCU's serial output so we can see it.
}
