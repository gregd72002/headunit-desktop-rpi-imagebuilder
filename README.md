# Minimal Raspberry Pi Linux configuration and Buildroot image to support headunit-desktop

Project based on https://github.com/romainreignier/minimal_raspberrypi_buildroot

Objectives:
- build stable image ready to flash that supports all functionality needed by headunit-desktop
- be fast to boot
- automatically starts headunit-desktop

Hardware:
- RPi 1,2 & 3 (with BT and WIFI)
- RPi 7" touchscreen

Nice to have:
- read-only partition to minimize issues with sudden power loss

### Instructions
Download and extract buildroot. Call it buildroot

Download this repo: 

    git clone https://github.com/gregd72002/headunit-desktop-rpi-imagebuilder

Create build and download directories

    mkdir build
    mkdir buildroot_dl
  
Prep

    cd build
    patch -d ../buildroot/ -p0 < ../headunit-desktop-rpi-imagebuilder/patches/buildroot.patch
    make BR2_EXTERNAL=../headunit-desktop-rpi-imagebuilder/ O=$PWD -C ../buildroot/ raspberrypi_defconfig

To change buildroot config

    make menuconfig

To change linux kernel config

    make linux-menuconfig

Build

    make


Flash

    dd if=images/sdcard.img of=/dev/XXXX bs=4MB


Running

    /opt/headunit-app

VNC (remote access)

    dispmanx_vncserver -r

Wifi
    Edit /etc/netowrk/interfaces and uncomment all the lines
    Edit /etc/wpa_supplicant and replace NETWORK and PASSWORD with your WiFi network details
    Reboot 
