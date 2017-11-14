#!/bin/bash
# run this script from the command line using 'sudo bash ./replaceDefaultFiles.sh' (assuming your in the same directory)
# This script replaces the default examples and library folders in the Arduiono IDE. 





mkdir cd /usr/share/arduino/libraries-backUp
mv /usr/share/arduino/libraries/* /usr/share/arduino/libraries-backUp/


cd /usr/share/arduino/libraries
git clone https://github.com/pi-bot/NeoPixel
git clone https://github.com/pi-bot/DC_motor-driver
