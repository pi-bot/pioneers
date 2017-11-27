### Serial with Python 

As is standard with many programming languages reading and writing over serial interfaces in python is straight-forward. 

TBC 
```python
import serial
import time
import pygame

board = serial.Serial("\\.\COM3", 9600, timeout = 1)
time.sleep(2)

screen = pygame.display.set_mode([300,100])
screen.fill([255,255,255])
pygame.display.set_caption("Windows Controller")

def forward():
   board.write("F")
   print("Forward")
def backward():
   board.write("B")
   print("Backward")
def left():
   board.write("L")
   print("Left")
def right():
   board.write("R")
   print("Right")
def stop():
   board.write("S")
   print("Stop")

while 1:
   key = pygame.key.get_pressed()
   for event in pygame.event.get():
       if event.type == pygame.QUIT:
           break
       elif event.type == pygame.KEYDOWN:
           if event.key == pygame.K_w:
                   print"Forward"
                   forward()
           if event.key == pygame.K_a:
                   print"Left"
                   left()
           if event.key == pygame.K_s:
                   print"Backward"
                   backward()
           if event.key == pygame.K_d:
                   print"Right"
                   right()
           if event.key == pygame.K_ESCAPE:
                   break
       elif event.type == pygame.KEYUP:
                   print"Stop"
                   stop()
   pygame.display.update()
pygame.quit
```
