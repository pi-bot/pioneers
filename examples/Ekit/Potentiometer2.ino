/*
 from https://oscarliang.com/using-potentiometer-to-control-piezo-speaker-for-v/
 as we vary the potentiometer, the pitch varies too. Oscar’s project.
*/

#include "pitches.h"
// notes to play, corresponding to the 3 sensors:
// 21 pitches
int notes[] = {
NOTE_B0,NOTE_C1,NOTE_D1,NOTE_E1,NOTE_F1,NOTE_G1,NOTE_A1,
NOTE_B1,NOTE_C2,NOTE_D2,NOTE_E2,NOTE_F2,NOTE_G2,NOTE_A2,
NOTE_B2,NOTE_C3,NOTE_D3,NOTE_E3,NOTE_F3,NOTE_G3,NOTE_A3};

int Tone = 0;
int speakerPin = 3;

void setup() {
// do nothing
}

void loop() {

// get potentiometer input
int sensorValue = analogRead(A0); // 0 – 1023

// calculate corresponding, divide by 49 as we have 21 pitches. 1023/13 ~ 21
int pitch = sensorValue/49;

tone(speakerPin, notes[pitch], 100);

// delay to let it finish ‘tone’ instruction.
delay(100);

}
