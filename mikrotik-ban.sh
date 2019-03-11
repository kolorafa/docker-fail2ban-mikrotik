#!/bin/sh
#itDesk

mtips=$1
list=$2
banip=$3
timeout=$4
comment=$5


if [ "$timeout" == "" ]; then
 echo "Missing timeout value";
 exit 1;
fi

for ip in `echo $mtips|sed s/";"/" "/g`; do 
    echo Banning $banip on $ip with $timeout timeout and comment: $comment
    command="/ip firewall address-list add list=$list timeout=$timeout address=$banip comment=\"$comment\"";
    echo $command
    ssh -o StrictHostKeyChecking=no -o BatchMode=yes $MIKROTIK_USER@$ip $command
    #ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -oBatchMode=yes ssh@$ip $command
done
