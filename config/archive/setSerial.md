This is the extract for setting the serial if the config option for the raspberry pi no loonger works:

```
##-------------------------------------------------------------------------------------------------

## Enable Serial Port
# Findme look at using sed to toggle it
echo 'Enabling Serial Port...'
if grep -q 'enable_uart=1' /boot/config.txt; then
    echo 'enable_uart=1 is already set - skipping'
else
    echo 'ena
    ble_uart=1' | sudo tee -a /boot/config.txt
fi

## Disable Serial login
echo 'Disabling Serial Login...'
    # Rpi 3
    systemctl stop serial-getty@ttyS0.service
    systemctl disable serial-getty@ttyS0.service

## Disable Boot info
echo 'Disabling Boot info...'
#sudo sed -i'bk' -e's/console=ttyAMA0,115200.//' -e's/kgdboc=tty.*00.//'  /boot/cmdline.txt
sed -i'bk' -e's/console=serial0,115200.//'  /boot/cmdline.txt


##-------------------------------------------------------------------------------------------------
```
