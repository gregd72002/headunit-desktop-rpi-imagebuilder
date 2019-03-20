#!/bin/sh
umount /mnt/v1
umount /mnt/v2

rm -rdf /mnt/usb/share/boot
rm -rdf /mnt/usb/share/p

mkdir /mnt/usb/share/boot
mkdir /mnt/usb/share/p

mount -t vfat /mnt/usb/build/images/sdcard.img /mnt/v1 -o loop,offset=512
cp -R /mnt/v1/* /mnt/usb/share/boot/
umount /mnt/v1

echo "root=/dev/nfs rw nfsroot=192.168.1.205:/mnt/usb/share/p,vers=4,tcp nfsrootdebug ip=dhcp rootwait elevator=deadline console=serial0,115200" > /mnt/usb/share/boot/cmdline.txt
cp /mnt/usb/bootcode.bin /mnt/usb/share/boot/

mount -t ext4 /mnt/usb/build/images/sdcard.img /mnt/v1 -o loop,offset=33554944
rsync -xa --progress --exclude /nfs /mnt/v1/ /mnt/usb/share/p
umount /mnt/v1

service tftpd-hpa restart



