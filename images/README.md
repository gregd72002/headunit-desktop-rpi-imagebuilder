# Prebuilt Headunit-desktop image for Raspberry Pi

### Instructions
Download, extract and flash onto SD card (min 256MB).

Edit headunit.cfg (it is on the vfat partition so can be done from any computer).

### Usage
Given autostart is enabled in heaudnit.cfg, just plug the SD card in and power up your RPi.
You should be able to use VNC to connect a remote desktop.

Default user: root, password: headunit 

### Notes
You might want to disable networking to speed up boot. Just run: chmod -x /etc/init.d/S40network.
Or for finer adjustments edit /etc/network/interfaces

