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
