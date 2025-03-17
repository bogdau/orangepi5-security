#!/bin/bash 
IMG_MOUNT_DIR="/mnt/image"
cp orangepi.img orangepi_ready_made.img
sudo losetup -fP orangepi_ready_made.img

if [ ! -d $IMG_MOUNT_DIR]; then
    sudo mkdir -p $IMG_MOUNT_DIR
fi 
sudo mount /dev/loop0p2 $IMG_MOUNT_DIR

cp src/*.service $IMG_MOUNT_DIR/lib/systemd/system/
cp src/*.sh $IMG_MOUNT_DIR/etc/

sudo chmod 777 $IMG_MOUNT_DIR/etc/check_serial.sh 

if [ ! -h "$IMG_MOUNT_DIR/etc/systemd/system/default.target.wants/check_serial.service" ]; then
    cd "$IMG_MOUNT_DIR/etc/systemd/system/default.target.wants/"
    ln -s /lib/systemd/system/check_serial.service check_serial.service
    echo "--- Create symlink to check_serial.service ---"
fi

if [ ! -h "$IMG_MOUNT_DIR/etc/systemd/system/default.target.wants/take_serial.service" ]; then
    cd "$IMG_MOUNT_DIR/etc/systemd/system/default.target.wants/"
    ln -s /lib/systemd/system/take_serial.service take_serial.service
    echo -e "--- Create symlink to take_serial.service ---"
fi 

sync 
sleep 3

sudo umount $IMG_MOUNT_DIR
sudo losetup -d /dev/loop0