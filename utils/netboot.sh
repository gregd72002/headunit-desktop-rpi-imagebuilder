#!/bin/sh

BUILD_FOLDER=/mnt/usb/build
TMP_MOUNT_FOLDER=/mnt/v1
TFTPD_FOLDER=/mnt/usb/share/boot #boot folder
NFS_FOLDER=/mnt/usb/share/p #root folder

umount $TMP_MOUNT_FOLDER

rm -rdf $TFTPD_FOLDER 
rm -rdf $NFS_FOLDER 

mkdir $TFTPD_FOLDER 
mkdir $NFS_FOLDER

mount -t vfat $BUILD_FOLDER/images/sdcard.img $TMP_MOUNT_FOLDER -o loop,offset=512
cp -R $TMP_MOUNT_FOLDER/* $TFTPD_FOLDER/
umount $TMP_MOUNT_FOLDER

echo "root=/dev/nfs rw nfsroot=192.168.1.205:$NFS_FOLDER,vers=4,tcp nfsrootdebug ip=dhcp rootwait elevator=deadline console=serial0,115200" > $TFTPD_FOLDER/cmdline.txt
#cp /mnt/usb/bootcode.bin /mnt/usb/share/boot/

mount -t ext4 $BUILD_FOLDER/images/sdcard.img $TMP_MOUNT_FOLDER -o loop,offset=33554944
rsync -xa --progress --exclude /nfs $TMP_MOUNT_FOLDER/ $NFS_FOLDER
umount $TMP_MOUNT_FOLDER

service tftpd-hpa restart

#reboot RPi



