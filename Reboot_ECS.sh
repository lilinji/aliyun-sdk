#!/bin/bash
#########################################################################
# File Name: Reboot_ECS.sh
# Author: lilinji
# mail: lilinji@novogene.com
# Created Time: Mon 11 Dec 2017 02:37:36 PM CST
#########################################################################
if [ ! -f "own_ecs.list" ]; then
     echo "I Will  Reboot ECS Compute"
     echo "I Will  Reboot ECS Compute.."
     sleep 1
     echo "Reboot ECS Compute ing......"
less down_ecs.list  |awk '{print $3}' |sed '/^$/d' |while read l; do  echo "aliyuncli ecs RebootInstance --InstanceId"  $l "--ForceStop true"; done |sh
fi

