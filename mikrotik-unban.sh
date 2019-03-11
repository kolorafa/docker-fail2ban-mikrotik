#!/bin/sh
#itDesk
#require "read" permission or it will silently fail

mtips=$1
list=$2
banip=$3

if [ "$banip" = "" ]; then
 echo "Missing timeout value";
fi

for ip in `echo $mtips|sed s/";"/" "/g`; do 
    echo Removing $banip from $list list on $ip MikroTik
    command="/ip firewall address-list remove [/ip firewall address-list find list=$list address=$banip]";
    echo $command
    ssh -o StrictHostKeyChecking=no -oBatchMode=yes ssh@$ip "$command"
    #ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -oBatchMode=yes ssh@$ip "$command"
done
