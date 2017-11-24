import RPi.GPIO as GPIO
import time
import threading

#This program use the board numerotation for GPIOs, so up left is 1 and down right is 40
STEPPER_GPIOS = [16,33,32,18]#[23,13,12,24]

class Stepper():
      
    def __init__(self):
        GPIO.setmode(GPIO.BOARD)
        self.stopThread = False
        self.movementFinished = True
        #Stepper PINs to output
        for pin in range(4):
            GPIO.setup(STEPPER_GPIOS[pin],GPIO.OUT)
    def turn(self,angle,speed):
        self.movementFinished = False
        self.stopThread = False
        self.__move__(angle,speed)

    def turnAsync(self,angle,speed):
        #start the thread controlling GPIOs
        try:
            self.movementFinished = False
            self.stopThread = False
            t = threading.Thread(target=self.__move__, args=(angle,speed,))
            t.start()
        except:
            print 'Error launching stepper thread'

    def stop(self):
        self.stopThread = True

    def isMovementFinished(self):
        return self.movementFinished

    def __move__(self,angle,speed):
        try:
            if(speed>100):
                speed = 100
            elif(speed == 0):
                self.movementFinished = True
                self.stopThread = True
                return
            elif(speed<1):
                speed = 1

            speedTimer = 0.02-0.018/100.0*float(abs(speed))# result between 0.002<->0.02
            numberOfStep = int(512.0/360*abs(angle))
            print speedTimer,numberOfStep
            if(angle > 0):
                for i in range(0,numberOfStep):
                    if self.stopThread:
                        break
                    for pin in range(4):
                        if self.stopThread:
                            break
                        GPIO.output(STEPPER_GPIOS[pin],True) 
                        if pin < 3:
                            GPIO.output(STEPPER_GPIOS[pin+1],True)
                        else:
                            GPIO.output(STEPPER_GPIOS[0],True)
                        time.sleep(speedTimer)
                        GPIO.output(STEPPER_GPIOS[pin],False)

            else:
                for i in range(0,numberOfStep):
                    if self.stopThread:
                        break
                    for pin in range(3,-1,-1):
                        if self.stopThread:
                            break
                        GPIO.output(STEPPER_GPIOS[pin],True)
                        if pin > 1:
                            GPIO.output(STEPPER_GPIOS[pin-1],True)
                        else:
                            GPIO.output(STEPPER_GPIOS[3],True)
                        time.sleep(speedTimer)
                        GPIO.output(STEPPER_GPIOS[pin],False)

            self.movementFinished = True
        except RuntimeError:
            self.movementFinished = True
        except Exception as e:
            print 'Error in stepper thread'
            print e, type(e).__name__
            self.movementFinished = True






if __name__ == '__main__':
    main()
