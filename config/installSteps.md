## About 
These are the steps to prepare the PiBot software from a fresh install of Raspian. They are tested on the new Raspian stretch release: **2017-09-07-raspbian-stretch.img**


### 1 Install latest Raspian

The latest OS for the Raspberry Pi can be found [Here](https://www.raspberrypi.org/downloads/raspbian/) and the official guide for installing images on your Raspberry Pi can be found [Here](https://www.raspberrypi.org/documentation/installation/installing-images/)

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

### 3 Configure VNC
VNC or Virtual NEtwork Connection allows you to connect to your systems desktop remotely over a network (including the internet).  The Raspberry Pi has a **VNC server** selected and now operational in its configs and it needs a couple of option changes to connect it to a **VNC viewer**.  (I use the inbuild VNC viewer Screen Sharing on my mac).  From the VNC Iconon on the desktop menu bar (top right next to bluetooth) select the VNC server interface window. From the munu pull down on the windows top-right select options.... Under **Encryption:** change to **prefere off**. under **Authentication** select **VNC password**.  Now on the right select **Users and Permissions**.  Double click the **Standard user (user)** from the top and choose a password that will be your login for this.  Click **apply**.  Now VNC is set up and ready to go. 
for more details see https://www.raspberrypi.org/documentation/remote-access/vnc/

## Remaining Steps
After the RAspberry Pi has been basically configured it is now ready to complete the installation and set up. Tihs includes 
1. Install required software packages (Arduino and minicom)
2. Configure the serial and reset pins to work with the piBot Board. 
3. Modify the Arduino IDE interface to a) upload to the piBot board b)replace the default example files with piBot examples
4.
5.






