
## Info on the system 
Running `cat /proc/version` gives info on the current os `Linux version 4.9.41-v7+ (dc4@dc4-XPS13-9333) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611) ) #1023 SMP Tue Aug 8 16:00:15 BST 2017`

`cat /proc/cpuinfo` gives info on the system processor. For our Raspberry Pi v3 this gives:

```
processor	: 0
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 38.40
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 1
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 38.40
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 2
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 38.40
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 3
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 38.40
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

Hardware	: BCM2835
Revision	: a02082
Serial		: 000000001d75025b
```


More recently you can also get model information: `cat /proc/device-tree/model`
```
Raspberry Pi 3 Model B Rev 1.2
```



There are two files in the Linux OS to alter the ststems hostname : `/etc/hostname` and `/etc/hosts`.  To edit them you can use nano:
```
sudo nano /etc/hostname
```
```
sudo nano /etc/hostname
```
We can edit the the name automatically by using the following script:

N.B. The quickw

Before making a script to change this for us lets create a directory to place our scripts.  

```
echo $PATH
```
This tells us the all the locations the system uses for scripts.  It will be convenient to keep our own scripts separate and lets create and at the directory to the **$PATH** System variable. 

```
sudo mkdir bin & sudo chmod u+x bin
```



```
#!/bin/sh

if test $# -eq 0
then
    echo "No name on command line."
    exit 1
fi

echo $1
NAME=$1
echo $NAME

echo $NAME | sudo tee  /etc/hostname

sudo sed -i -e 's/^.*hostname-setter.*$//g' /etc/hosts
echo "127.0.1.1      " $NAME " ### Set by hostname-setter"  | sudo tee -a /etc/hosts

sudo service hostname.sh stop
sudo service hostname.sh start

echo "Hostname set. Log out to see it on the command line"
```
