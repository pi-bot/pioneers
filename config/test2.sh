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

## Adding the Sleepy Pi to the Arduino environment
echo 'Adding the Sleepy Pi to the Arduino environment...'
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
# .../sketchbook/hardware/sleepy_pi2
if [ -d "/home/pi/sketchbook/hardware/sleepy_pi2" ]; then
    echo "sketchbook/hardware/sleepy_pi2 exists - skipping..."
else
    mkdir /home/pi/sketchbook/hardware/sleepy_pi2
    wget https://raw.githubusercontent.com/SpellFoundry/Sleepy-Pi-Setup/master/boards.txt
    mv boards.txt /home/pi/sketchbook/hardware/sleepy_pi2
fi

# .../sketchbook/hardware/sleepy_pi
if [ -d "/home/pi/sketchbook/hardware/sleepy_pi" ]; then
    echo "sketchbook/hardware/sleepy_pi exists - skipping..."
else
    mkdir /home/pi/sketchbook/hardware/sleepy_pi
    wget https://raw.githubusercontent.com/SpellFoundry/Sleepy-Pi-Setup/master/boards.txt
    mv boards.txt /home/pi/sketchbook/hardware/sleepy_pi
fi

## Setup the Sleepy Pi Libraries
echo 'Setting up the Sleepy Pi Libraries...'
cd /home/pi/sketchbook/libraries/
if [ -d "/home/pi/sketchbook/libraries/sleepy_pi2" ]; then
    echo "sleepy_pi2 Library exists - skipping..."
    # could do a git pull here?
else
    echo "Installing SleepyPi 2 Library..."
    git clone https://github.com/SpellFoundry/SleepyPi2.git
fi

if [ -d "/home/pi/sketchbook/libraries/Time" ]; then
    echo "Time Library exists - skipping..."
else
    echo "Installing Time Library..."
    git clone https://github.com/PaulStoffregen/Time.git
fi

if [ -d "/home/pi/sketchbook/libraries/PinChangeInt" ]; then
    echo "PinChangeInt Library exists - skipping..."
else
    echo "Installing PinChangeInt Library..."
    git clone https://github.com/GreyGnome/PinChangeInt.git
fi
cd ~


##-------------------------------------------------------------------------------------------------

# install i2c-tools
echo 'Enable I2C...'
if grep -q '#dtparam=i2c_arm=on' /boot/config.txt; then
  # uncomment
  sed -i '/dtparam=i2c_arm/s/^#//g' /boot/config.txt
else
  echo 'i2c_arm parameter already set - skipping...'
fi

echo 'Install i2c-tools...'
if hash i2cget 2>/dev/null; then
    echo 'i2c-tools are installed already - skipping...'
else
    sudo apt-get install -y i2c-tools
fi

##-------------------------------------------------------------------------------------------------
echo "PiBot setup complete! Please reboot."
exit 0
##-------------------------------------------------------------------------------------------------
