# --- T2-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
# 
# T2 SDE: target/share/firmware/build.sh
# Copyright (C) 2004 - 2008 The T2 SDE Project
# 
# More information can be found in the files COPYING and README.
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- T2-COPYRIGHT-NOTE-END ---
#
#Description: firmware

. $base/misc/target/functions.in

set -e

. target/share/initramfs/build.sh

# set firmware preparation directory
imagelocation="$build_toolchain/firmware"

# cylinder size in bytes (16 heads x 63 sectors/track x 512 bytes/sector)
cylinder_size="516096"
sectors_per_cylinder="1008"

echo "Preparing initramfs image from build result ..."

rm -rf $imagelocation{,.img}
mkdir -p $imagelocation ; cd $imagelocation
mkdir root_stage
mkdir root_stage/boot
mkdir root_stage/boot/grub
mkdir asterisk_stage
mkdir loop

# copy system into staging directories
cp ../../usr/lib/grub/i386-t2/* root_stage/boot/grub/
cp ../../../../target/share/firmware/menu.lst root_stage/boot/grub/
cp ../../boot/vmlinuz root_stage/boot/
cp ../initramfs.igz root_stage/boot/
cp -Rp ../../asterisk/* asterisk_stage/

# root partition size calculation
root_size=`du --bytes -s root_stage | cut -f 1`
root_cylinder_count=`expr $root_size / $cylinder_size + 5`
root_start_sector="63"
root_start_offset=`expr $root_start_sector \* 512`
root_end_sector=`expr $sectors_per_cylinder \* $root_cylinder_count`
echo "root     = $root_size bytes"
echo "root     = $root_cylinder_count cylinders"
echo "root     = $root_start_offset offset start"
echo "root     = sectors ($root_start_sector - $root_end_sector)"

# asterisk partition size calculation
asterisk_size=`du --bytes -s asterisk_stage | cut -f 1`
asterisk_cylinder_count=`expr $asterisk_size / $cylinder_size + 5`
asterisk_start_sector=`expr $root_end_sector + 1`
asterisk_start_offset=`expr $asterisk_start_sector \* 512`
asterisk_end_sector=`expr $sectors_per_cylinder \* $asterisk_cylinder_count + $asterisk_start_sector`
echo "asterisk = $asterisk_size bytes"
echo "asterisk = $asterisk_cylinder_count cylinders"
echo "asterisk = $asterisk_start_offset offset start"
echo "asterisk = sectors ($asterisk_start_sector - $asterisk_end_sector)"

# total image size calculation
total_cylinder_count=`expr $root_cylinder_count + $asterisk_cylinder_count`
echo "image    = $total_cylinder_count cylinders"

# write a binary container for the disk image
dd if=/dev/zero of=firmware.img bs=$cylinder_size count=$total_cylinder_count

# associate it with a loop device
losetup /dev/loop0 firmware.img

# partition the loop device
sfdisk -D -C$total_cylinder_count -S63 -H16 /dev/loop0 << EOF
,$root_cylinder_count,L,*
,,L
;
;
EOF

# parse root and asterisk partition block counts
root_blocks=`fdisk -l -C$total_cylinder_count -S63 -H16 -s /dev/loop0 | grep loop0p1 | sed 's/ \+/ /g' | cut -d " " -f 5 | sed 's/[^0-9]//g'`
asterisk_blocks=`fdisk -l -C$total_cylinder_count -S63 -H16 -s /dev/loop0 | grep loop0p2 | sed 's/ \+/ /g' | cut -d " " -f 4 | sed 's/[^0-9]//g'`
echo "root     = $root_blocks blocks"
echo "asterisk = $asterisk_blocks blocks"

# done partitioning, unconfigure loop device
losetup -d /dev/loop0

# setup loop device for root partition, format then unconfigure
losetup -o$root_start_offset /dev/loop0 firmware.img
mke2fs -m0 -b1024 /dev/loop0 $root_blocks
mount -text2 /dev/loop0 loop
cp -Rp root_stage/* loop/
umount /dev/loop0
losetup -d /dev/loop0

# setup loop device for asterisk partition, format then unconfigure
losetup -o$asterisk_start_offset /dev/loop0 firmware.img
mke2fs -m0 -b1024 /dev/loop0
mount -text2 /dev/loop0 loop
cp -Rp asterisk_stage/* loop/
umount /dev/loop0
losetup -d /dev/loop0

# install grub onto the image
echo "device (hd0) firmware.img
geometry (hd0) $total_cylinder_count 16 63
root (hd0,0)
setup (hd0)
quit

" | grub --device-map=/dev/null --batch --no-pager --no-floppy --no-curses

mv firmware.img ../