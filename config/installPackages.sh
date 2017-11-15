!/bin/bash
# run this script from the command line using 'sudo bash ./install.sh' (assuming your in the same directory) (can also be run from other scripts as root)
# This script is the dedicated to installing all software dependencies for the PiBot kit robot that are not present in the default Raspian Distro
#. These packages are:  
#  The Arduino IDE - development enviroment for the PiBot's firmware 
#  Minicom - a text-based serial port communications program. Used by the Raspian OS for two way communication to the PiBot MCU. Is mored capable than the Arduino IDE's built in console. 
# VIM - text editor - most people will find something like nano easier and better. 
#
## Install Arduino
echo 'Installing Arduino IDE...'
program="arduino"
condition=$(which $program 2>/dev/null | grep -v "not found" | wc -l)
if [ $condition -eq 0 ] ; then
    apt-get install arduino -y
    # create the default sketchbook and libraries that the IDE would normally create on first run
    mkdir /home/pi/sketchbook
    mkdir /home/pi/sketchbook/libraries
else
    echo "Arduino IDE is already installed - skipping"
fi

## Install Vim
echo 'Installing VIM...'
program="vim"
condition=$(which $program 2>/dev/null | grep -v "not found" | wc -l)
if [ $condition -eq 0 ] ; then
    apt-get install vim -y
else
    echo "VIM is already installed - skipping"
fi

echo "Package Installation Script Complete"

##-------------------------------------------------------------------------------------------------
