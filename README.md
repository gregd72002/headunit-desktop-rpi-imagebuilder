# Minimal Raspberry Pi 3 Linux configuration and Buildroot image to support headunit-desktop

Project based on https://raw.githubusercontent.com/romainreignier/minimal_raspberrypi_buildroot

Objectives:
- be fast to boot
- build image ready to flash that supports all functionality needed by headunit-desktop
- with wifi and bluetooth support
- automatically starts headunit-desktop

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
    make BR2_EXTERNAL=../headunit-desktop-rpi-imagebuilder/ O=$PWD -C ../buildroot/ raspberrypi3_minimal_defconfig

To change buildroot config
    make menuconfig

To change linux kernel config
    make linux-menuconfig

Build
    make


Flash
    dd if=images/sdcard.img of=/dev/XXXX bs=4MB
