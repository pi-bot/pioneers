import serial
import time
import pygame

sendCmd = serial.Serial('/dev/ttyS0', 9600, timeout = 1)
time.sleep(2)

screen = pygame.display.set_mode([300,100])
screen.fill([255,255,255])
pygame.display.set_caption("Windows Controller")


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
def s1():
   sendCmd.write("1")
   print("Initiated speed mode 1")
def s2():
   sendCmd.write("1")
   print("Initiated speed mode 2")   
def s3():
   sendCmd.write("1")
   print("Initiated speed mode 3")   
def s4():
   sendCmd.write("1")
   print("Initiated speed mode 4")   

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
           if event.key == pygame.K_1:
                   print"Power mode 1"
                   s1()  
           if event.key == pygame.K_2:
                   print"Power mode 2"
                   s2()   
           if event.key == pygame.K_3:
                   print"Power mode 3"
                   s3()   
           if event.key == pygame.K_4:
                   print"Power mode 4"
                   s4()                     
           if event.key == pygame.K_ESCAPE:     
                   break
       elif event.type == pygame.KEYUP:
                   print"Stop"
                   stop()
   pygame.display.update()
pygame.quit
