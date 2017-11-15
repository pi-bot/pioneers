# About 
These steps set up the full software enviroment of the PiBot from a fresh install of Raspian. They are put here for reference and interest only. 

**N.B.** the supplied sd card is pre-configured and should work *out-the-box*! There is now a collection of pre-made software images on the website here: (http://www.pibot.org/pioneers/distro/)

These steps have been tested as working on the Raspian stretch release: **2017-09-07-raspbian-stretch.img**

1. Install latest Raspian 
2. Change Default Settings 
3. Configure Remote Access
4. Run the install scripts from **master.sh**

## 1 Install latest Raspian

The latest OS for the Raspberry Pi can be found [here](https://www.raspberrypi.org/downloads/raspbian/) and the official guide for installing images on your Raspberry Pi can be found [here](https://www.raspberrypi.org/documentation/installation/installing-images/)

The latest version is **Raspian Stretch with Desktop** and this is based on the Debian Stretch Linux OS distribution. 

- **Version**: September 2017
- **Release date**: 2017-09-07
- **Kernel version**: 4.9

Once you have a working Raspian OS on the Raspberry Pi you can then proceed to make customisations and install the PiBot software. 

## 2 OS Customizations

Good practice following the booting of a new distro image is to update all installed packages:
```
sudo apt-get update && sudo apt-get upgrade -y 
```
Next thng to do is to replace the default username and passwords and to change some other common defaults for use with the PiBot. piBotRaspian has a configuration GUI for making common alterations to its OS.  This is opened from  *Start > Preferences > Raspberry Pi Configuration*.
Once opened we can now make the following changes: 

From the **System** tab :
- Change the password from *raspberry* to something else (e.g. *piBot*)
- Change the hostname from *raspberrypi* to something else (e.g. *piBot-X2*)

From the **interfaces** tab select to enable :
- Camera
- SSH
- VNC
- Serial 

From the **Localisation** tab select *Set Keyboard* and select :
- **Country**: United States
- **Variant**: English (US)

Thats it! You can now reboot to bring these changes into effect.

The only other change I made was to change the default background image of the Desktop. I did this by going to  *Start > Preferences > Appearance Settings*.  Then I selected *auror.jpg* from the **Picture** input. 


## 3 Remote User Interfacing with the Raspberry Pi 

Remote desktop and command-line interfaces can be set up to access and control the Raspberry Pi remotely. This is the best way to control robots and means that we can eventually un-tether the system so that it can operate without any wire attachements whats-so-ever.

A laptop is pehaps the best device for interfacing with the piBot as it is semi-portable (can move around with the robot), its good for typing (much better than a talblet), and should have full networking capabilities (a usb/ethernet adapter can also be used for wired ethernet connections).  The following guides are to set up both remote access through a remote desktop as well as through the command line (Secure Shell access SSH).  

### Remote Desktop with VNC

VNC or Virtual Network Connection allows you to connect to your systems desktop remotely over a network (including the internet).  The Raspberry Pi has a **VNC server** that we selected in *Raspi-Config*. It now needs a couple of option changes to connect it to a **VNC viewer**.  (I use the inbuilt VNC viewer *Screen Sharing app* on my mac):

- From the VNC Icon on on the desktop menu bar (top right next to bluetooth) select the VNC server interface window. From the menu pull-down on the windows top-right select **options**.... 
- Under **Encryption:** change to **prefer off**.
- Under **Authentication** select **VNC password**.
- Now on the right select **Users and Permissions**.  Double click the **Standard user (user)** from the top and choose a password that will be your login for this.  Click **apply**.  Now VNC is set up and ready to go!

For more details see https://www.raspberrypi.org/documentation/remote-access/vnc/

#### Testing remote access 
As with most things technical its a good idea to test any changes before assuming that they have been implemented and are working.  The next step is to check and verify remote access with **VNC** and **SSH**.

I did this both with from my mac laptop that was connected to the same WIFI network as Raspberry Pi. (There are many guides on the internet for remote access from other systems e.g. windows (google is your friend ) ).

To test SSH I simply logged in from a terminal using:
```
ssh piBot@piBot-X2.local 
```
 Successfull access indicated it was working.  To test VNC I used the inbuilt **Screen Sharing** app and this also connected without issue. 

## 4 Run Bash Install Scripts

**Bash** is the native and popular linux scripting language that is used in the Raspain command line interface.  Bash scripts  are predominantly sequences of terminal commands that are run to complete various tasks. See [here](https://ryanstutorials.net/bash-scripting-tutorial/bash-script.php) for a basic intro.  

This directory contains all the scripts to set up a customised and configured software enviroment to work with the PiBot. In order to do this in an easy-to-follow-way I have created a *master* script: **master.sh** that then calls all other scripts that perform individual tasks. This **master** - **sub-script** arrangement makes it possible to run and test each task independently and makes the whole install process more manageable and easy to debug. 

The scrips are commented so the best way to see how they work and what changes they are making is to look at them directly.  For now here is an overaview of all scripts with a brief description of what they do. 

0) **Compatible.sh** - checks that the Raspberry Pi and Raspian enviroment are compatible
1) **installPackages.sh** checks and install required software packages
2) **configureSerial.sh**	configure a serial connection to the PiBot Board
3) **configureAudio.sh** configure the Audio Interfaces
4) **modAvrdude.sh**	modifies avrdude and reset pin (used to send firmware to the PiBot board)
5) **configureArduino.sh** customise and configure the arduiono IDE
6) **installPiBotFiles.sh**	populate the arduino IDE with PiBot libraries and excercise files
7)  **master.sh**	the lead script that runs the sub-scripts and logs the results.

The **programmers.txt	& boards.txt** are used by the  **configureAudio.sh** script to modify the Arduino IDE. The **archive** and **related** folders are for previous code that are left for interest or reference.
