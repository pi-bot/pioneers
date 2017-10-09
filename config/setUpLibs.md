Th install script **test2.sh** is now working. The final change will be to auto-update the IDE files.

# Modify the Arduino IDE 
Here we'll explain how the Arduino IDE can be modified to work with the PiBot.
#### Approach 
We wanted to modify the IDE to simplify its options and add some unique styling.
- create a unique PiBot board configuration and make it the IDE 's default instead of the *UNO*.. **Boards.txt**
- Create a custom way to program the microcontroller using a **RasPi ISP**
- Replace the default **Examples** directory with support files for the learning system
- Replace the default **Libraries** directory with ones specific to the PiBot.
- **preference.txt** Here we'll customise some settings 

### File locations
The **preference.txt** is found in 
```
~/.arduino
```
### Modifying the Examples and Libraries Directories
The Examples Directory is replaced with the 4 learning sections for the tutorials.
This is done by replacing files in the default **/usr/share/arduino/examples** directory:

```
mv /usr/share/arduino/examples /usr/share/arduino/examples-original
```

Then we can replace with the examples from the repo:

```
mv /location/of/arduino-tutorials/examples /usr/share/arduino/examples
```

See the seaxples-original folder for how the directory is organised.

### Modifying the Libraries Directories
The Libraries Directory can also be replaced and simplified for the learning course.
The Libraries directory is found here: **/usr/share/arduino/libraries**. 
A **Test-hardware** library is added to be used to test all the robots hardware. 

```
mv /location/of/arduino-tutorials/test-hardware /usr/share/arduino/libraries/test-hardware
```


```
echo "avrdude customisation complete. Now setting up the boards.txt"
  wget https://github.com/pi-bot/.v2/blob/master/boards.txt
  wget https://github.com/pi-bot/.v2/blob/master/programmers.txt
  cd /usr/share/arduino/hardware/arduino
  mv boards.txt boards.txt.bak
  mv /tmp/boards.txt .
  mv programmers.txt programmers.txt.bak
  mv /tmp/programmers.txt .
  echo "Setup complete now. Launch the Arduino IDE and check that you can use it."
  
  ```
  
  ### Prorgrammers.txt
  
 The programmers file is located here: `/usr/share/arduino/hardware/arduino/programmers.txt`
 
 ```
rpigpio.name=RPi GPIO
rpigpio.protocol=linuxgpio
```


This is how sleepy pi set up the libs

```
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


# .../sketchbook/hardware/piBot
if [ -d "/home/pi/sketchbook/hardware/piBoti" ]; then
    echo "sketchbook/hardware/piBot exists - skipping..."
else
    mkdir /home/pi/sketchbook/hardware/piBot
    wget https://raw.githubusercontent.com/SpellFoundry/Sleepy-Pi-Setup/master/boards.txt
    mv boards.txt /home/pi/sketchbook/hardware/piBot
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
```
