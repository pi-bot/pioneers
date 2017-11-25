if (Serial.available()>0) {
  serIn=Serial.read()
  if (SerIn=='A') { 
    ...do something...
  }
  while (Serial.available()>0) serIn=Serial.read();
} 
