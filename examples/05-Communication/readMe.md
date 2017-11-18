The PiBot implements a high-speed two-way serial interface between the MCU and the Raspberry Pi.  This can be used to send and receive large amounts of data including specific commands and requests for data.

The serial data from the MCU can be seen visibly on a console though more interestingly can be parsed and used by programs and processes running on the Raspberry Pi.  The aim of the PiBot project is to develop and use an integration with Python running on the Raspberry Pi. 

This communication directory is intended to locate examples of serial communications that lead towards a full Application Interface with Python.  As a starting point several examples have been ported from the default Arduino Example Communication folder. These were made for communication with the **Processing** language though can as easily be set up for use with Python.

## Ported Arduino Examples 
These have associated tutorial pages by arduino (see links).

- [ASCIITable](https://www.arduino.cc/en/Tutorial/ASCIITable): Demonstrates Arduino's advanced serial output functions.
- [Dimmer](https://www.arduino.cc/en/Tutorial/Dimmer): Move the mouse to change the brightness of an LED.
- [Physical Pixel](https://www.arduino.cc/en/Tutorial/PhysicalPixel): Turn a LED on and off by sending data to your Arduino from Processing or Max/MSP.
- [Read ASCII String](https://www.arduino.cc/en/Tutorial/ReadASCIIString): Parse a comma-separated string of integers to fade an LED.
- [Serial Call Response](https://www.arduino.cc/en/Tutorial/SerialCallResponse): Send multiple variables using a call-and-response (handshaking) method.
- [Serial Call Response ASCII](https://www.arduino.cc/en/Tutorial/SerialCallResponseASCII): Send multiple variables using a call-and-response (handshaking) method, and ASCII-encode the values before sending.
- [Serial Event](https://www.arduino.cc/en/Tutorial/SerialEvent): Demonstrates the use of SerialEvent().

Please suggest further sketch and examples for use with the PiBot!
