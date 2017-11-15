#!/bin/bash
# run this script from the command line using 'sudo bash ./checkCompatible.sh' (assuming your in the same directory)
# This script checks compatibibility for installing the PiBot software.
echo " "
echo "This installation script has the following requirements:"
echo "1) Script must be run as root user"
echo "2) Raspberry Pi must be v3"
echo "3) The OS must be the latest 'Raspian Stretch'"
echo "2) There must be a working internet connection"
echo " "
echo "Will now perform tests for these requirements before continuing ...."
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
