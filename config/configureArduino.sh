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
cd /usr/share/arduino/hardware/arduino
if [ -f "boards.txt.bak" ]
then
	echo "boards.txt already backed up."
  rm -rf boards.txt
else
	mv boards.txt boards.txt.bak
fi

if [ -f "programmers.txt.bak" ]
then
	echo "programmers.txt already backed up."
  rm -rf programmers.txt
else
	mv programmers.txt programmers.txt.bak
fi

cp ~/pioneers/config/programmers.txt programmers.txt
cp ~/pioneers/config/boards.txt boards.txt

##-------------------------------------------------------------------------------------------------
