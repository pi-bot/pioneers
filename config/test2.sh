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
echo "2) Raspberry Pi must be v3"
echo "3) The OS must be the latest 'Raspian Strech'"
echo "2) There must be a working internet connection"
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
echo "1: Root execution: PASSED. Now checking for Raspberry Pi board version..."
echo "=================================="

REVISION="$(cat /proc/cpuinfo | grep 'Revision' | awk '{print $3}' | sed 's/^1000//')"
SERIAL="$(cat /proc/cpuinfo | grep Serial | cut -d ':' -f 2)"
if [[ "$REVISION" == "a02082" ]]; then
  echo "Board confirmed as Raspberry Pi version 3. Serial number is:"
  echo  $SERIAL
 else
  echo "Board is not identified as Raspberry Pi version 3 See 'cat /proc/cpuinfo' for more info. Will now exit..."
  exit 1
fi

echo " "
echo "2. Board compatibility: PASSED. Now checking for compatible OS version..."
# check if system is using the latest 'stretch' version of Raspian
osInfo=$(cat /etc/os-release)
if [[ $osInfo == *"stretch"* ]]; then
#    Stretch=true   // May need this flag for later development
    echo "OS version detected as *stretch*"
else
    echo "This script only works on Raspian Stretch at this time. Not Compatible. Will now exit..."
    exit 1
fi

echo "3. Compatible OS: PASSED. Now checking for internet connectivity..."
echo "=================================="
wget -q --tries=2 --timeout=100 http://google.com -O /dev/null
if [ $? -eq 0 ];then
        echo "Internet Connection Verified"
else
        echo "Unable to Connect, try again !!!"
        exit 0
fi


## Start Installation

echo " "
echo "System has satified all requirement for PiBot Installation..."
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
    echo "avrdude has now been configured..."
else
    echo "$program is already installed - skipping..."
fi

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
# .../sketchbook/hardware
if [ -d "/home/pi/sketchbook/hardware" ]; then
    echo "sketchbook/hardware exists - skipping..."
else
    mkdir /home/pi/sketchbook/hardware 
fi


# .../sketchbook/hardware/piBot
if [ -d "/home/pi/sketchbook/hardware/piBot" ]; then
    echo "sketchbook/hardware/piBot exists - skipping..."
else
    mkdir /home/pi/sketchbook/hardware/piBot
#    wget https://raw.githubusercontent.com/SpellFoundry/Sleepy-Pi-Setup/master/boards.txt
cd ~/home/pi/bin/avrdude-rpi-1-master/
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
echo "PiBot setup complete! Will now reboot in 10 seconds."
sleep 10
sudo /sbin/shutdown -r now
exit 0
##-------------------------------------------------------------------------------------------------
