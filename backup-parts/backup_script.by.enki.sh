#!/bin/bash

        if [ "$(id -u)" != "0" ]; then
				echo "You have to be ROOT to run this script"
				sleep 2;
				echo "Trying to run as ROOT..."
				sleep 2;
				su -c "sh /sdcard/backup-parts/backup_script.by.enki.sh"
	exit 1;
	else  
				echo "You are now ROOT"
				sleep 2;
                    
fi
echo "##################################################"
echo "-HTC Desire 820G Plus Backup Script by Enki v1.0-"
sleep 4;
echo "mounting system"
mount -o rw,remount /system
sleep 4;
echo "process will starting"
sleep 4;
backup_folder="/sdcard/backup-parts"
mkdir -p /$backup_folder
echo "creating folder $backup_folder"
sleep 4;
echo "please wait creating system image..."
dd if=/dev/block/mmcblk0p6 of=/sdcard/backup-parts/system.img bs=4096
echo "created system image"
sleep 4;
echo "please wait creating boot image..."
dd if=/dev/block/mmcblk0 of=/sdcard/backup-parts/boot.img bs=4096 skip=7584 count=2560
echo "created boot image"
sleep 4;
echo "please wait creating logo..."
dd if=/dev/block/mmcblk0 of=/sdcard/backup-parts/logo.img bs=4096 skip=14368 count=2048
echo "created logo"
sleep 4;
echo "please wait creating recovery image..."
dd if=/dev/block/mmcblk0 of=/sdcard/backup-parts/recovery.img bs=4096 skip=10144 count=2560
echo "created recovery image"
sleep 4;
echo "create a flashable zip? [Y,n]"
read -r input
if [[ $input == "Y" || $input == "y" ]]; then
        echo "set compression level[1,3,5,7,9]" "default: 5"
        read -r c_level
        echo "creating flashable rom zip..."
        sleep 4;
        cd $backup_folder || exit
        sleep 4;
        echo "setting to $c_level"
        7z a -mx="$c_level" my_rom.zip system.img boot.img recovery.img logo.img META-INF/com/google/android/update-binary META-INF/com/google/android/updater-script
        echo "deleting old files..."
        rm system.img logo.img boot.img recovery.img
        sleep 2;
        echo "created flashable rom"
        sleep 2;
        echo "process finished your zip file in $backup_folder"     
else
        echo "your backup files in $backup_folder"
      
fi
echo "##################################################"
exit 0;