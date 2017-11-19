#!/bin/bash
# This script can be run from the command line using 'sudo bash installPiBotFiles.sh' (assuming your in the same directory)
# This script reconfigures the RaspiPi serial interface for use with the PiBot development board.
##-------------------------------------------------------------------------------------------------

## Replacing the Arduino's IDE  example and library directories 

echo "Now replacing the Arduino IDE's examples directories"

if [ -d "/usr/share/arduino/examples.backup" ]
then
	echo "examples directory already backed up."
 	rm -rf /usr/share/arduino/examples
else
	mv /usr/share/arduino/examples /usr/share/arduino/examples.backup
fi

cp -r ../examples /usr/share/arduino/examples

##-------------------------------------------------------------------------------------------------

echo "Now replacing the Arduino IDE's library directories"

if [ -d "/usr/share/arduino/libraries.backup" ]
then
	echo "library directory already backed up."
else
 	mkdir /usr/share/arduino/libraries.backup
	mv /usr/share/arduino/libraries/* /usr/share/arduino/libraries.backup/
fi
cd /usr/share/arduino/libraries
git clone https://github.com/pi-bot/NeoPixel
git clone https://github.com/pi-bot/DC_motor_driver
git clone https://github.com/pi-bot/Servo

echo "Arduino library configured and installation script complete. "

##-------------------------------------------------------------------------------------------------
