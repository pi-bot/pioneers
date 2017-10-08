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
