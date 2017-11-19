#define SERVO_PIN         5  // pin 6 is also available by default on the piBot board.

void setup()
{
  pinMode(SERVO_PIN, OUTPUT);

}

int lenMicroSecondsOfPeriod = 25 * 1000; // 25 milliseconds (ms)
int lenMicroSecondsOfPulse = 1 * 1000; // 1 ms is 0 degrees
int first = 0.7 * 1000; //0.5ms is 0 degrees in HS-422 servo
int end = 3.7 * 1000;
int increment = 0.01 * 1000;

void loop()
{
    int current = 0;
    for(current = first; current <end; current+=increment){
         // Servos work by sending a 25 ms pulse.  
         // 0.7 ms at the start of the pulse will turn the servo to the 0 degree position
         // 2.2 ms at the start of the pulse will turn the servo to the 90 degree position 
         // 3.7 ms at the start of the pulse will turn the servo to the 180 degree position 
         // Turn voltage high to start the period and pulse
         digitalWrite(SERVO_PIN, HIGH);

         // Delay for the length of the pulse
         delayMicroseconds(current);

         // Turn the voltage low for the remainder of the pulse
         digitalWrite(SERVO_PIN, LOW);

         // Delay this loop for the remainder of the period so we don't
         // send the next signal too soon or too late
         delayMicroseconds(lenMicroSecondsOfPeriod - current); 
    }
    for(current = end; current >first; current-=increment){
         // Servos work by sending a 20 ms pulse.
         // 0.7 ms at the start of the pulse will turn the servo to the 0 degree position
         // 2.2 ms at the start of the pulse will turn the servo to the 90 degree position
         // 3.7 ms at the start of the pulse will turn the servo to the 180 degree position
         // Turn voltage high to start the period and pulse
         digitalWrite(SERVO_PIN, HIGH);

         // Delay for the length of the pulse
         delayMicroseconds(current);

         // Turn the voltage low for the remainder of the pulse
         digitalWrite(SERVO_PIN, LOW);

         // Delay this loop for the remainder of the period so we don't
         // send the next signal too soon or too late
         delayMicroseconds(lenMicroSecondsOfPeriod - current);
    }
}
