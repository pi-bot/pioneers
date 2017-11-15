!/bin/bash
# This script can be run from the command line using 'sudo bash modAvrdude.sh' (assuming your in the same directory)
# This script reconfigures the RaspiPi serial interface for use with the PiBot development board.
##-------------------------------------------------------------------------------------------------

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
