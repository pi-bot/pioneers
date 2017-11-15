!/bin/bash
# This script can be run from the command line using 'sudo bash configureArduino.sh' (assuming your in the same directory)
# This script reconfigures the Arduino IDE for use with the PiBot development board.
##-------------------------------------------------------------------------------------------------

## Adding the piBot to the Arduino environment

echo 'Adding the piBot to the Arduino environment...'
# ...setup sketchbook
if [ -d "/home/pi/sketchbook" ]
then
    echo "sketchbook exists - skipping..."
else
    mkdir /home/pi/sketchbook
fi
# ...setup sketchbook/libraries
if [ -d "/home/pi/sketchbook/libraries" ]
then
    echo "sketchbook/libraries exists - skipping..."
else
    mkdir /home/pi/sketchbook/libraries
fi

echo "Now customising the boards.txt and programmers.txt files"

if [ -f "/usr/share/arduino/hardware/arduino/boards.txt.bak" ]
then
	echo "boards.txt already backed up."
  rm -rf /usr/share/arduino/hardware/arduino/boards.txt
else
	mv /usr/share/arduino/hardware/arduino/boards.txt /usr/share/arduino/hardware/arduino/boards.txt.bak
fi

if [ -f "/usr/share/arduino/hardware/arduino/programmers.txt.bak" ]
then
	echo "programmers.txt already backed up."
  rm -rf /usr/share/arduino/hardware/arduino/programmers.txt
else
	/usr/share/arduino/hardware/arduino/programmers.txt /usr/share/arduino/hardware/arduino/programmers.txt.bak
fi

cp programmers.txt /usr/share/arduino/hardware/arduino/programmers.txt
cp boards.txt /usr/share/arduino/hardware/arduino/boards.txt

echo "boards.txt and programmers.txt swapped. Arduiono configuration script complete."
##-------------------------------------------------------------------------------------------------
