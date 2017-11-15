!/bin/bash
# This script can be run from the command line using 'configureAudio.sh' (assuming your in the same directory)
# This script reconfigures the Raspberry Pi's Audio interfaces to output to the PiBot's onboard audio amplifier.
##-------------------------------------------------------------------------------------------------

## Setting up and configuring Audio 
echo 'Setting up and configuring the piBots Audio'
amixer cset numid=3 1
sh -c "echo 'dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2' >> /boot/config.txt"
echo 'audio configuration complete'

##-------------------------------------------------------------------------------------------------
