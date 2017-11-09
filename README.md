# PiBot Pioneers
Welcome to the online PiBot Pioneers repository! This is the home for the development of all the PiBot's code as well as the open hardware body parts.  The repos [wiki](https://github.com/pi-bot/pioneers/wiki) is the place to learn about the code. (N.B. still under development.) See the [PiBot Pioneers Website](http://www.pibot.org/pioneers) for further support. 

## Private repos from the command line
As your reading this you must have gained access to gitHub via your GitHub username:).  Here's a quick note on the use of private repos. Their key difference is their requirement for *authentication*.  This leads to a different form for accessing the repo. 

For public repos creating a clone would typically follow the form: 
```
git clone git://github.com/pi-bot/pioneers.git
```
For **private** repos however a slightly different form is required:

```
git clone https://username@github.com/pi-bot/pioneers.git
```
So for me this is:
```
git clone https://pi-bot@github.com/pi-bot/pioneers.git
```
The difference you will see is the association with the specific user.  All Pioneers usernames are added to the private repo and this restricts access to only these users.  The second issue however is with  setting up **unobtrusive authentication**. Everytime you use git as a specific user you will be required to issue your password, that is unless you set up secure authentication with **ssh**.  By adding your raspberry pi's (and or laptops) public ssh key to your GitHub account this will enable you to access all provate repositories with out the need for a password everytime. This is especially 

This is especially useful if you use git commands in scripts. e.g. a script to update the **pioneer** repo automatically on each boot or at scheduled times.

https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

Once you upload your public key to your GitHub account settings its then easy to use the repo without any need for passwords. In order to do this however another alternative form of accessing the resource needs to be used:

```
git clone git@github.com:pi-bot/pioneers.git
```
I think this is because the git system is now accessing the repo on your behalf.

## Programming overview
As the getting started guide will show there are two ways of coding with the Pibot:

-  Either the PiBots on-board microcontroller directly using C++ via the on-board Arduino IDE. 
-  Or using python at a higher level. As well as using python to control the PiBots native Raspberry Pi connections (such as the camera and servos) a default Python API is provided that makes it possible to link and abstract commands to the lower level microcontroller. 

WORK IN PROGRESS 


Check back soon for progress.
