## About 
These are the steps to prepare the PiBot software from a fresh install of Raspian. They are tested on the new Raspian stretch release: **2017-09-07-raspbian-stretch.img**


### 1 Install latest Raspian

The latest OS for the Raspberry Pi can be found [here](https://www.raspberrypi.org/downloads/raspbian/) and the official guide for installing images on your Raspberry Pi can be found [here](https://www.raspberrypi.org/documentation/installation/installing-images/)

The latest version is **Raspian Stretch with Desktop** and this is based on the based on the Debian Stretch Linux OS distribution. 

- **Version**: September 2017
- **Release date**: 2017-09-07
- **Kernel version**: 4.9

Once you have a working Raspian OS on the Raspberry Pi you can then proceed to make customisations and install the PiBot software. 


### 2 Changes to the default OS 
Raspian has a configuration GUI for making common alterations to its OS.  This is opened from  *Start > Preferences > Raspberry Pi Configurion*.
Once opened we can now make the following changes: 

From the **System** tab :
- Change the password from *raspberr* e.g. *piBot*
- Change the hostname from *raspberrypi* to something like *piBot-X1*

From the **interfaces** tab select to enable :
- Camera
- SSH
- VNC
- Serial 

From the **Localisation** tab select *Set Keyboard* and select :
- **Country**: United States
- **Variant**: English (US)

Thats it! You can now reboot to bring these changes into effect.

## 3 Remote User Interfacing with the Raspberry Pi 

Remote desktop and command-line interfaces can be set up to access and control the Raspberry Pi remotely. This is the best way to control robots and means that we can eventually un-tether the system so that it can operate without any wire attachements whats-so-ever.

A laptop is pehaps the best device for interfacing with the piBot as it is semi-portable (can move around with the robot), its good for typing (much better than a talblet), and should have full networking capabilities (a usb/ethernet adapter can also be used for wired ethernet connections).  The following guides are to set up both remote access through a remote desktop as well as through the command line (Secure Shell access SSH).  

#### Remote Desktop with VNC

VNC or Virtual NEtwork Connection allows you to connect to your systems desktop remotely over a network (including the internet).  The Raspberry Pi has a **VNC server** selected and now operational in its configs and it needs a couple of option changes to connect it to a **VNC viewer**.  (I use the inbuild VNC viewer Screen Sharing on my mac).  From the VNC Iconon on the desktop menu bar (top right next to bluetooth) select the VNC server interface window. From the munu pull down on the windows top-right select options.... Under **Encryption:** change to **prefere off**. under **Authentication** select **VNC password**.  Now on the right select **Users and Permissions**.  Double click the **Standard user (user)** from the top and choose a password that will be your login for this.  Click **apply**.  Now VNC is set up and ready to go. 
for more details see https://www.raspberrypi.org/documentation/remote-access/vnc/

#### Remote Command Line Interface with SSH

We have already set up ssh in the Raspberry Pi Config and now we shall make it possible to connect to the system securely without the need for a password.  I use a mac laptop that has as terminal built in which is convenient. There is additional free software for command line interfacing in windows and please see the official raspberry pi guide [here](https://www.raspberrypi.org/documentation/remote-access/ssh/)

Once you have SSH working its a good idea to be able to make connections without the need for passwords. Refer to 
[this](https://www.raspberrypi.org/documentation/remote-access/ssh/passwordless.md/) guide for how to do this.  

I did:

```
ssh-keygen -t rsa -C harry@Harrys-MacBook-Pro
```
You will then be given a prompt to save the generated keys. Save it in the default location (/home/pi/.ssh/id_rsa) by just hitting Enter.


```cat ~/.ssh/id_rsa.pub | ssh <USERNAME>@<IP-ADDRESS> 'cat >> .ssh/authorized_keys'```
e.g.

```cat ~/.ssh/id_rsa.pub | ssh pi@192.168.15.4 'cat >> .ssh/authorized_keys' ```



## Remaining Steps
After the RAspberry Pi has been basically configured it is now ready to complete the installation and set up. Tihs includes 
1. Install required software packages (Arduino and minicom)
2. Configure the serial and reset pins to work with the piBot Board. 
3. Modify the Arduino IDE interface to a) upload to the piBot board b)replace the default example files with piBot examples
4.
5.


### 4 Installing and Configurign the Arduino IDE

A install script has been made to install and configure the Arduino IDE. 

https://github.com/pi-bot/pioneers/config/autoInstall.sh

copy and execute this script.


Once run it will then reboot the system.  Then open the arduino IDE. On first start it will ask for the default folder for keeping sketches.  Just choose sketchbook/ from the bootome of the folder list.

Then to test go to :cd 

The arduino IDE 

## 2  Communicating with the PiBot Board

**avrdude** is a command-line interface for downloading and uploading to microcontrollers and enabling automation.  It has many features and is also used by the Arduiono IDE. See [here]( http://www.ladyada.net/learn/avr/avrdude.html) for a good overview:
We use it to automate the downloading and and uploading of code to the PiBot arduino compatible microcontroller (Atmel 328P)
This guide will help you:

- Configure your Raspberry Pi and Arduino IDE to work with the PiBot board (avrdude is included in the install)
- Configure the serial output of the Raspberry Pi to link with the Microcontroller (By default the linux kernal outputs to the Raspberry Pi's Serial port)
- Modify the setup with avrdude so that the Raspberry Pi can interface with it seamlessly (this involves setting up a unique reset pin instead of the typical reset pin normally used with arduinos)

** NB ** these setup instructions are different for the Raspberry Pi and other Pi versions.   Please look out for specific instructions relating to your speciific version.This set up is compatible with the new Raspain Stretch operating system only. 

OK here we go:


### Setting up the serial interface

By default kernal messages are sent to serial so the first step is to disable this.
For all Pi's apart from Pi 3 do:
```
sudo systemctl stop serial-getty@ttyAMA0.service
sudo systemctl disable serial-getty@ttyAMA0.service
```
If you have a Pi 3 you do the following instead (only do this if you have a Pi 3):
```
sudo systemctl stop serial-getty@ttyS0.service 
sudo systemctl disable serial-getty@ttyS0.service
```
Then add this line to the Raspberry Pi config file to enable serial on the GPIO pins:
```
sudo nano /boot/config.txt
```
add this line to the end:
```
enable_uart=1
```
### Edit cmdline.txt

Then we need to delete some data from the /boot/cmdline.txt file 
```
sudo nano /boot/cmdline.txt
```
remove the string 'console=serail0,115200'

###mapping
Then setup the mapping for linking the default arduiono serial interface with ours 
**N.B.** this step is not required for the Raspberry Pi 3 which already uses the arduino default.
```
sudo vim /etc/udev/rules.d/80-pibot.rules
```

### add these and close
KERNEL=="ttyAMA0", SYMLINK+="ttyS0",GROUP="dialout",MODE:=0666
KERNEL=="ttyACM0", SYMLINK+="ttyS1",GROUP="dialout",MODE:=0666

Now we need to alter the DTR reset pin for use with avrdude
many projects using the Raspberry Pi to program microcontrollers have used this approach
TO DO fork original files and include as PiBot install: (edit the autoreset file to include correct pin 7)
```
git clone  https://github.com/CisecoPlc/avrdude-rpi
cd avrdude-rpi
sudo cp autoreset /usr/bin
sudo cp avrdude-autoreset /usr/bin
sudo mv /usr/bin/avrdude /usr/bin/avrdude-original
sudo ln -s /usr/bin/avrdude-autoreset /usr/bin/avrdude
```

Then I am editing the /usr/bin/autoreset to use pin 7 instead and increase the time to 0.32.
:great then we can proceed to install the pibot firmware 
for the Raspberry Pi 3 the serial connection is given over /dev/ttyS0 
for all other raspberry pi's the connection is over /dev/ttyAMA0 

###Finally
I can add the Pibot as a board to be accessable from the arduiono IDE 

**The below did not work **
# following another guide we find that its should be is 
cd /usr/share/arduino/hardware/arduino
then instead edit the existing boards.txt to add the entry. 

```
mkdir /home/pi/sketchbook
mkdir /home/pi/sketchbook/hardware 
mkdir /home/pi/sketchbook/hardware/pi_bot
```

then create a board file in the pi_bot folder 
```
vim /home/pi/sketchbook/hardware/pi_bot/Boards.txt
```
```

##############################################################

pibot.name=Pi Bot

pibot.upload.protocol=arduino
pibot.upload.maximum_size=30720
pibot.upload.speed=57600

pibot.bootloader.low_fuses=0xFF
pibot.bootloader.high_fuses=0xDA
pibot.bootloader.extended_fuses=0x05
pibot.bootloader.path=arduino:atmega
pibot.bootloader.file=ATmegaBOOT_168_atmega328_pro_8MHz.hex
pibot.bootloader.unlock_bits=0x3F
pibot.bootloader.lock_bits=0x0F

pibot.build.mcu=atmega328p
pibot.build.f_cpu=8000000L
pibot.build.core=arduino:arduino
pibot.build.variant=arduino:standard

```
Reboot and the board should now be accessible in the dropdown menu in the IDE



