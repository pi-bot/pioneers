# Getting Started

Each Pioneer has been given a breadboard and a few components to begin learning about 


## Step 1: Let there be light
This exercise requires connecting V+ (indicated by a (+) on the top right pin-out) to the top row of the breadboard.  The breadboard is designed to make electrical physical connections without the need of solder.  See the above image for how it is constructed.  Notice that the conductive strips of the breadboard repeat in vertical columns and that there is also an electrical break between the top of the breadboard and the bottom.  Each point of the breadboard can be addressed with the top rows being assigned the letter 'A' and rows descending through the alphabet all the way through to the last row represented by  'J'.  The columns are addressed from '1' on the far left all the way to '17'on the far right.  Our first circuit  then has the following 
 connections:

- red wire connected from V+ (marked +) to the top-left 'A1' node of the breadboard.  
- a resistor connected from node B1 to B5. 
- an Led connected from C5 to C6 
- a black wire connected from D5 to F8 
- Finally a wire connected from J8 to the Gnd Pin.

The V+ is the power supply pin for our circuit and if measured will be at a regulated 3.3V.  
The circuit [ground](https://en.wikipedia.org/wiki/Ground_(electricity)) marked **GND** completes the return path for the electric current and has a reference point of 0V. 

Before you go ahead and built the circuit the final thing to note is that the LED has a positive side and an negative side. It's important to connected its longer leg (positive) to the V+ side and its shorter leg (negative) to Gnd.  The reason for this is in its name- Diodes receive current in only one direction and we'll cover this in more detail later.  For now set up the circuit as below  and make sure that your light turns on! (N.B. board needs also to be powered first either from the battery  (power switch to the right) or from a 5V supply to the mini- usb connector) 


### So what's going on? 
 Before moving ahead to more complex circuits there's already a lot going on here that's worth knowing about.   We'll look at this now as it will form the basic understanding of electronics that we can then progress from.  Fistly let's consider some of the basics on electricity itself.  Whist the true nature of electricity is actually very mysterious the technical description is that Electricity is the ‘flow of electric charge’. This typically is means the flow of electrons through a metal conductor. Our circuit, for example, carries electricity with a continuous passage for electrons to flow through the wires and components.  A flow of electrons is useful because along the way all kinds of useful effects and changes can be made.  In our case the flow of electrons is causing the led to emit light but it could as easily be used to create sound, induce motion through magnetic fields, embody logic states and processing operations, channel communications, and many other kinds of physical effects. In robotics electrical flow can create all kinds of artificial intelligence and changes to the world that can be a lot of fun as well as useful.  
