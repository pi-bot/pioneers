# PiBot Pioneers
Welcome to the online PiBot Pioneers repository! This is the home for the development of all the PiBot's code.  The repos **wiki** is also the place to learn about the code. 

## Getting access 


## Private repos from the command line
As your reading this you must have gained access to gitHub. 

For public repos creating a clone would typically follow the form: 
```
git clone git://github.com/username/reponame.git
```
For **private** repos however a slightly different form is required:

```
git clone https://username@github.com/username/reponame.git
```
The oifference you will see is the association with the specicfic user.  All Pioneers usernames are added to the private repo and this restricts access to only these users.  The second issue however is with **authentication**. Everytime you use git as a specific user you will be required to issue your password, that is unless you set up secure authentication with **ssh**.  By adding your raspberry pi's (and or laptops) public ssh key to your GitHub account this will enable you to access all provate repositories with out the need for a password everytime. This is especially 

This is especially useful if you use git commands in scripts. e.g. a script to update the **pioneer** repo automatically on each boot or at scheduled times.



https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/


getting started guides for the PiBot build-your-own robot.  

Currently the getting started guide is being deleloped in the https://github.com/pi-bot/pioneers/wiki

## Programming overview
As the getting started guide will show there are two ways of coding with the Pibot:

-  Either the PiBots on-board microcontroller directly using C++ via the on-board Arduino IDE. 
-  Or using python at a higher level. As well as using python to control the PiBots native Raspberry Pi connections (such as the camera and servos) a default Python API is provided that makes it possible to link and abstract commands to the lower level microcontroller. 

WORK IN PROGRESS 


Check back soon for progress.
