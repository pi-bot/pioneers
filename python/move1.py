import serial
ser = serial.Serial('/dev/ttyACM0', 9600)
ser.open()
# here a delay is needed
ser.write('4') # go forward
ser.close()
