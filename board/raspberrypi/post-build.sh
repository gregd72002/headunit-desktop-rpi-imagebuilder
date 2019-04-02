#!/bin/sh

set -u
set -e

#add mount for boot
if [ ! -e ${TARGET_DIR}/boot ]; then
    mkdir ${TARGET_DIR}/boot
fi
if [ -e ${TARGET_DIR}/etc/fstab ]; then
    grep -qE 'mmcblk0p1' ${TARGET_DIR}/etc/fstab || \
	    sed -i "\$a/dev/mmcblk0p1  /boot           vfat    rw              0       0" ${TARGET_DIR}/etc/fstab
fi

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Add users to groups 
if [ -e ${TARGET_DIR}/etc/group ]; then
#add dbus group if not exist
    grep -qE 'dbus:x:1000:dbus' ${TARGET_DIR}/etc/group || \
	    sed -i "\$adbus:x:1000:dbus" ${TARGET_DIR}/etc/group
#add root to dbus 
    grep -qE '1000:dbus,root' ${TARGET_DIR}/etc/group || \
	    sed -i 's/\<1000:dbus\>/&,root/' ${TARGET_DIR}/etc/group
#add pulse-access group if not exist
    grep -qE 'pulse-access:x:1004:pulse' ${TARGET_DIR}/etc/group || \
	    sed -i "\$apulse-access:x:1004:pulse" ${TARGET_DIR}/etc/group
#add root to pulse-access
    grep -qE '1004:pulse,root' ${TARGET_DIR}/etc/group || \
	    sed -i 's/\<1004:pulse\>/&,root/' ${TARGET_DIR}/etc/group
fi

# Remove unused firmware files
UNNEEDED_FILES=
#UNNEEDED_FILES="brcmfmac43143.bin \
#    brcmfmac43143-sdio.bin \
#    brcmfmac43236b.bin \
#    brcmfmac43241b0-sdio.bin \
#    brcmfmac43241b4-sdio.bin \
#    brcmfmac43241b5-sdio.bin \
#    brcmfmac43242a.bin \
#    brcmfmac43340-sdio.bin \
#    brcmfmac43362-sdio.bin \
#    brcmfmac43430a0-sdio.bin \
#    brcmfmac43455-sdio.bin \
#    brcmfmac43569.bin \
#    brcmfmac43570-pcie.bin \
#    brcmfmac43602-pcie.ap.bin \
#    brcmfmac43602-pcie.bin"

if [ -d ${TARGET_DIR}/lib/firmware/brcm ]; then
    cd ${TARGET_DIR}/lib/firmware/brcm/
    for f in $UNNEEDED_FILES; do
        if [ -f $f ]; then
            rm $f
        fi
    done
fi
