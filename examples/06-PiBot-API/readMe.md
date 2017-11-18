The directory for the development of the PiBot API.  This is firmware that creates an application interface with the Raspberry Pi. It means that the Raspberry Pi can use Python to control the MCU and its sub-functions from a higher level. There are many uses and benefits for doing this. 

An obvious use case for this is to delegate navigation and position control to the MCU. From the Raspberry Pi, rather than sending low level commands to hardware (e.g. put left/right on for a given time interval, read encoder values, adjust speed and power to each motor etc),  clean and simple higher level commands can be given.  For instance (move forward 3 meters at 50% speed, and at a 14 degree angle, - let me know when you get there!).

There are several ways to interface to the MCU using python and many of these are covered in the arduono info page:(https://playground.arduino.cc/Interfacing/Python)

The most complete and developed solution looks to be the **PyCmdMessenger** library that is build off the **Arduino CmdMessenger** library. 

## PyCmdMessenger

This is a python implementation of the Arduino **CmdMessenger** that has been actively developed over the last few year. This looks like it will be ideal for use with the PiBot. 

The message format is:
```
Cmd Id, param 1, [...] , param N;
```

Although the field separator ',' and command separator ';' can be changed

The library can:

-both send and receive of commands
-Both write and read multiple arguments
-Both write and read all primary data types
-Attach callback functions any received command

The library supports any primary data types, and zero to many multiple arguments. Arguments can either be sent in plain text (to be human readable) or in binary form (to be efficient).

Both [PyCmdMessenger](https://github.com/harmsm/PyCmdMessenger) and [Arduino_CmdMessenger](https://github.com/thijse/Arduino-CmdMessenger) are avaliable and maintained on GitHub. (see links)

This directory is to show examples of useing the **PyCmdMessenger** to send receive data and commands with the MCU from Python and will be used to demontrate versions of complete API's.

### Dynamic Firmware
One of the exciting things about hte PiBot is its ability to dynamically flash and change the Firmware on the MCU *on-the-fly*.  This means that firware can adapt to various different situations and contexts. Possibilities include:
- Firware for mapping a location
- Firware dedicated to movement and navigation 
- Firmware dedicated to danceing and entertainment
- Firmware dedicated to playing particular games

It would be amazing if Pioneers get as far as developping their own API's and sharing them with the community from here!
