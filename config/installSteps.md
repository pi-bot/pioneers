## About 
These are the steps to prepare the PiBot software from a fresh install of Raspian. **N.B.** the supplied sd card is pre-configured and should work *out-the-box*. These steps have been tested as working on the Raspian stretch release: **2017-09-07-raspbian-stretch.img**

1. Install Raspian 
2. Change the Configs 
3. Run the Pibot Install Script
4. Modify the IDE


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
After the Raspberry Pi has been basically configured it is now ready to complete the installation and set up. This includes 
1. Install required software packages (Arduino and minicom)
2. Configure the serial and reset pins to work with the piBot Board. 
3. Modify the Arduino IDE interface to a) upload to the piBot board b)replace the default example files with piBot examples
4.
5.

**N.B.** There is now an install script that does the complete steps automatically. Best to use this and look at the comments and commands in the script if you want to know whats going on in more detail.



### 4 Installing and Configurign the Arduino IDE

A install script has been made to install and configure the Arduino IDE. 

https://github.com/pi-bot/pioneers/blob/master/config/install.sh

Once run it will then reboot the system.  Then open the arduino IDE. On first start it will ask for the default folder for keeping sketches.  Just choose sketchbook/ from the bootom of the folder list.

A new sketch should then open in the IDE.  From the top menu you can check that everything is configured correctly by looking under **Tools>** Here you should see the following:

- Board > **PiBot**
- Serial Port > **/dev/ttyS0**
- Programmer > **Raspberry Pi GPIO**
 
If this is all set then you should be ready to upload your first sketch. 

For Troubleshooting uploading to the PiBot MCU please look for help on the PiBot Forum.

