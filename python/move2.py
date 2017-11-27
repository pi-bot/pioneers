import serial
import time
import pygame

sendCmd = serial.Serial('/dev/ttyS0', 9600, timeout = 1)
time.sleep(2)


def forward():
   sendCmd.write("w")
   print("Forward")
def backward():
   sendCmd.write("x")
   print("Backward")
def left():
   sendCmd.write("a")
   print("Left")
def right():
   sendCmd.write("d")
   print("Right")
def stop():
   sendCmd.write("x")
   print("Stop")

while 1:
   key = pygame.key.get_pressed()
   for event in pygame.event.get():
       if event.type == pygame.QUIT:
           break
       elif event.type == pygame.KEYDOWN:
           if event.key == pygame.K_UP:
                   print"Forward"
                   forward()
           if event.key == pygame.K_LEFT:
                   print"Left"
                   left()
           if event.key == pygame.KEY_DOWN:
                   print"Backward"
                   backward()
           if event.key == pygame.K_RIGHT:
                   print"Right"
                   right()
           if event.key == pygame.K_ESCAPE:
                   break
       elif event.type == pygame.KEYUP:
                   print"Stop"
                   stop()
pygame.quit
