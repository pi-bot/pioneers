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

cp -r /usr/share/arduino/libraries.backup/Servo /usr/share/arduino/libraries/ && cp -r /usr/share/arduino/libraries.backup/Stepper /usr/share/arduino/libraries/

cd /usr/share/arduino/libraries

sed -i '13s/9/6/' Servo/examples/Knob/Knob.ino
sed -i '13s/9/6/' Servo/examples/Knob/Knob.ino
sed -i '15s/9/6/' Servo/examples/Sweep/Sweep.ino
sed -i '15s/9/6/' Servo/examples/Sweep/Sweep.ino

git clone https://github.com/pi-bot/NeoPixel
git clone https://github.com/pi-bot/PBmotorDriver
git clone https://github.com/pi-bot/NewPing
#git clone https://github.com/br3ttb/Arduino-PID-Library/

echo "Arduino library configured and installation script complete. "

##-------------------------------------------------------------------------------------------------
