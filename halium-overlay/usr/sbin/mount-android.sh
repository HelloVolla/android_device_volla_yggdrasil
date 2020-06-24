#!/bin/bash

# On systems with A/B partition layout, current slot is provided via cmdline parameter.
ab_slot_suffix=$(grep -o 'androidboot\.slot_suffix=..' /proc/cmdline |  cut -d "=" -f2)
[ ! -z "$ab_slot_suffix" ] && echo "A/B slot system detected! Slot suffix is $ab_slot_suffix"

find_partition_path() {
    label=$1
    path="/dev/$label"
    # In case fstab provides /dev/mmcblk0p* lines
    for dir in by-partlabel by-name by-label by-path by-uuid by-partuuid by-id; do
        # On A/B systems not all of the partitions are duplicated, so we have to check with and without suffix
        if [ -e "/dev/disk/$dir/$label$ab_slot_suffix" ]; then
            path="/dev/disk/$dir/$label$ab_slot_suffix"
            break
        elif [ -e "/dev/disk/$dir/$label" ]; then
            path="/dev/disk/$dir/$label"
            break
        fi
    done
    echo $path
}

parse_mount_flags() {
    org_options="$1"
    options=""
    for i in $(echo $org_options | tr "," "\n"); do
        [[ "$i" =~ "context" ]] && continue
        options+=$i","
    done
    options=${options%?}
    echo $options
}

echo "checking for vendor mount point"

sys_vendor="/sys/firmware/devicetree/base/firmware/android/fstab/vendor"
if [ -e $sys_vendor ]; then
    label=$(cat $sys_vendor/dev | awk -F/ '{print $NF}')
    path=$(find_partition_path $label)
    [ ! -e "$path" ] && exit "Error vendor not found"
    type=$(cat $sys_vendor/type)
    options=$(parse_mount_flags $(cat $sys_vendor/mnt_flags))
    echo "mounting $path as /vendor"
    mount $path /vendor -t $type -o $options
fi

if [ -d "/opt/halium-overlay/vendor" ]; then
    mount -t overlay overlay -o lowerdir=/opt/halium-overlay/vendor:/vendor /vendor
fi

if [ -d "/opt/halium-overlay/system" ]; then
    mount -t overlay overlay -o lowerdir=/opt/halium-overlay/system:/android/system /system
    mount -o bind /android/system /var/lib/lxc/android/rootfs/system
fi

# yggdrasil-specific overrides
mount -o bind /system/lib/modules /vendor/lib/modules

sys_persist="/sys/firmware/devicetree/base/firmware/android/fstab/persist"
if [ -e $sys_persist ]; then
    label=$(cat $sys_persist/dev | awk -F/ '{print $NF}')
    path=$(find_partition_path $label)
    # [ ! -e "$path" ] && exit "Error persist not found"
    type=$(cat $sys_persist/type)
    options=$(parse_mount_flags $(cat $sys_persist/mnt_flags))
    echo "mounting $path as /mnt/vendor/persist"
    mount $path /mnt/vendor/persist -t $type -o $options
fi

# Assume there's only one fstab in vendor
fstab=$(ls /vendor/etc/fstab*)
[ ! -e "$fstab" ] && echo "fstab not found" && exit

echo "checking fstab $fstab for additional mount points"

cat ${fstab} | while read line; do
    set -- $line

    # stop processing if we hit the "#endhalium" comment in the file
    echo $1 | egrep -q "^#endhalium" && break

    # Skip any unwanted entry
    echo $1 | egrep -q "^#" && continue
    ([ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]) && continue
    ([ "$2" = "/system" ] || [ "$2" = "/data" ] || [ "$2" = "/" ] \
    || [ "$2" = "auto" ] || [ "$2" = "/vendor" ] || [ "$2" = "none" ] \
    || [ "$2" = "/misc" ]) && continue
    ([ "$3" = "emmc" ] || [ "$3" = "swap" ] || [ "$3" = "mtd" ]) && continue

    label=$(echo $1 | awk -F/ '{print $NF}')
    [ -z "$label" ] && continue

    echo "checking mount label $label"

    path=$(find_partition_path $label)

    [ ! -e "$path" ] && continue

    mkdir -p $2
    echo "mounting $path as $2"
    mount $path $2 -t $3 -o $(parse_mount_flags $4)
done
