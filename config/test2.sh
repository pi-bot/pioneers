#!/bin/bash
echo -e "\E[32m"
echo " ____  __  ____   __  ____      ____  ____  ____  _  _  ____  ";
echo "(  _ \(  )(  _ \ /  \(_  _)    / ___)(  __)(_  _)/ )( \(  _ \ ";
echo " ) __/ )(  ) _ ((  O ) )(      \___ \ ) _)   )(  ) \/ ( ) __/ ";
echo "(__)  (__)(____/ \__/ (__)     (____/(____) (__) \____/(__)   ";
echo -e "\E[0m"
echo "Welcome to the PiBot Setup Installer."
echo " "
echo "This installation script has the following requirements:"
echo "1) Script must be run as root user"
echo "2) There must be a working internet connection"
echo "3) Currently this script is only compatible with the Raspian Strech on a Raspberry Pi v3"
echo " "
echo "Will now perfrom tests for these requirements before continuing ...."
echo " "
echo "1: Checking for execution as root...."

# Check whether script is being run as sudo
if [[ $EUID -ne 0 ]]; then
  	echo "This script must be run as root" 1>&2
  	exit 1
fi

echo " "
echo "Root execution: PASSED. Now checking for internet connectivity..."
echo "=================================="
wget -q --tries=2 --timeout=100 http://google.com -O /dev/null
if [ $? -eq 0 ];then
        echo "Internet Connection Verified"
else
        echo "Unable to Connect, try again !!!"
        exit 0
fi

echo " "
echo "Now checking for compatible OS version..."
# check if system is using the latest 'stretch' version of Raspian
osInfo=$(cat /etc/os-release)
if [[ $osInfo == *"stretch"* ]]; then
#    Stretch=true   // May need this flag for later development
    echo "OS version detected as *stretch*"
else
    echo "This script only works on Raspian Stretch at this time. Not Compatible. Will now exit..."
    exit 1
fi

## Start Installation

echo " "
echo "System has satified requirement for PiBot Installation..."
echo " "
echo 'Begin Installation ? (type Y followed by enter to proceed) '
read ReadyInput
if [ "$ReadyInput" == "Y" ]; then
    echo "Beginning installation..."
else
    echo "Aborting installation"
    exit 0
fi

##Update and upgrade
sudo apt-get update && sudo apt-get upgrade -y

##-------------------------------------------------------------------------------------------------
##-------------------------------------------------------------------------------------------------
## Test Area
# echo every line 
set +x

# exit 0
## End Test Area

##-------------------------------------------------------------------------------------------------
##-------------------------------------------------------------------------------------------------

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



## Setup the Reset Pin
echo 'Setup the Reset Pin...'
program="autoreset"
condition=$(which $program 2>/dev/null | grep -v "not found" | wc -l)
if [ $condition -eq 0 ]; then
    wget https://github.com/pi-bot/avrdude-rpi-1/archive/master.zip
    unzip master.zip
    cd ./avrdude-rpi-1-master/
    cp autoreset /usr/bin
    cp avrdude-autoreset /usr/bin
    mv /usr/bin/avrdude /usr/bin/avrdude-original
    cd /home/pi
    rm -f /home/pi/master.zip
    rm -R -f /home/pi/avrdude-rpi-1-master
    ln -s /usr/bin/avrdude-autoreset /usr/bin/avrdude
else
    echo "$program is already installed - skipping..."
fi

##-------------------------------------------------------------------------------------------------

# .../sketchbook/hardware/piBot
if [ -d "/home/pi/sketchbook/hardware/piBot" ]; then
    echo "sketchbook/hardware/piBot exists - skipping..."
else
    mkdir /home/pi/sketchbook/hardware/piBot
#    wget https://raw.githubusercontent.com/SpellFoundry/Sleepy-Pi-Setup/master/boards.txt
    mv boards.txt /home/pi/sketchbook/hardware/piBot
fi

#echo "avrdude customisation complete. Now setting up the boards.txt"
#  wget https://github.com/pi-bot/.v2/blob/master/boards.txt
# wget https://github.com/pi-bot/.v2/blob/master/programmers.txt
#  cd /usr/share/arduino/hardware/arduino
#  mv boards.txt boards.txt.bak
# mv /tmp/boards.txt .
#  mv programmers.txt programmers.txt.bak
#  mv /tmp/programmers.txt .
#  echo "Setup complete now. Launch the Arduino IDE and check that you can use it."





##-------------------------------------------------------------------------------------------------
echo "PiBot setup complete! Please reboot."
exit 0
##-------------------------------------------------------------------------------------------------
