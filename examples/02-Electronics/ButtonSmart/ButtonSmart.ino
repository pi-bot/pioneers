/*
*    simple debounce using delay, will block for 5mSec when state changes
*/

const uint32_t debounceTime = 5;  // 5 mSec, enough for most switches
const uint8_t switchPin     = 8;  // with n.o. momentary pb switch to ground
const uint8_t ledPin        = 13; // built-in led

const bool switchOn  = false;     // using INPUT_PULLUP
const bool switchOff = true;

bool lastState   = switchOff;
bool newState    = switchOff;
bool toggleState = false;

void setup()
{
  
  Serial.begin ( 9600 );
  Serial.println ( F ( __FILE__ ) );
  Serial.println ( F ( "Simple state change/debounce using delay." ) );
  Serial.println ( F ( "push on, push off -- with momentary contact switch" ) );
  
  pinMode ( switchPin, INPUT_PULLUP );
  pinMode ( ledPin, OUTPUT );
  
} // setup

void loop ()
{

  newState = digitalRead( switchPin );

  if( lastState != newState ) // state changed
  {
    delay( debounceTime );
    lastState = newState;
    
    // push on, push off
    if( newState == switchOn && toggleState == false )
    {
      toggleState = true;
      digitalWrite( ledPin, HIGH );
      Serial.println( F ( "Switched ON" ) );
    }
    else if( newState == switchOn && toggleState == true )
    {
      toggleState = false;
      digitalWrite( ledPin, LOW );
      Serial.println( F ( "Switched OFF" ) );
    }

  }  // if state changed

} // loop
