
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
