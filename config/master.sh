!/bin/bash
# run this script from the command line using 'sudo bash ./install.sh' (assuming your in the same directory)
# This script is the **master** script that completes the full PiBot configuration and code installation from a vanilla raspian image.
# sub-scripts can be run on individual lines:
# bash script1.sh ;  (in this case the process will continue whether the script is exited successfully or not.
# or if you want to fun a script on condition of a successfull completion you can use the form:
# bash script1.sh &&
# bash script2.sh &&
# bash script3.sh
# 
# execution and errors in the script are logged in the install.log iogfile
log=install.log
$ date | tee $log
echo -e "\E[32m"
echo " ____  __  ____   __  ____      ____  ____  ____  _  _  ____  ";
echo "(  _ \(  )(  _ \ /  \(_  _)    / ___)(  __)(_  _)/ )( \(  _ \ ";
echo " ) __/ )(  ) _ ((  O ) )(      \___ \ ) _)   )(  ) \/ ( ) __/ ";
echo "(__)  (__)(____/ \__/ (__)     (____/(____) (__) \____/(__)   ";
echo -e "\E[0m"
echo "Welcome to the PiBot Setup Installer."
bash checkCompatible.sh &&
## Start Installation
echo " "
echo "System has satified all requirement for PiBot Installation..."  | tee -a $log
echo " "
echo "The master sript will now complete the following operations:"
echo "1) check and install required software packages"
echo "2) configure a serial connection to the PiBot Board"
echo "3) configure the Audio Interfaces"
echo "4) modify avrdude and reset pin'"
echo "5) customise and configure the arduiono IDE"
echo "6) populate the arduino IDE with PiBot libraries and excercise files"
echo 'Begin Installation ? (type Y followed by enter to proceed) '
read ReadyInput
if [ "$ReadyInput" == "Y" ]; then
    echo "Beginning installation..." | tee -a $log
else
    echo "Aborting installation"  | tee -a $log
    exit 0
fi
echo " "
bash ./installPackages.sh &&
echo "packages installed successfully "  | tee -a $log
bash ./configureSerial.sh &&
echo "serial configured successfully "  | tee -a $log
bash ./configureAudio.sh &&
echo "Audio configured successfully "  | tee -a $log
bash ./modAvrdude.sh &&
echo "avrDude modded succesfully"  | tee -a $log
bash ./configureArduino.sh &&
echo "Arduino configured successfully "  | tee -a $log
bash ./installPiBotFiles.sh &&
echo "PiBot files integrated successfully "  | tee -a $log
##-------------------------------------------------------------------------------------------------
echo "PiBot setup complete!" | tee -a $log
$ date | tee $log
echo "Will now reboot in 20 seconds. This script can terminated before a reboot with 'cntrl+c' "
sleep 20
sudo /sbin/shutdown -r now
exit 0
##-------------------------------------------------------------------------------------------------
