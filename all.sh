#!/bin/bash
#########################################################################
# File Name: all.sh
# Author: lilinji
# mail: lilinji@novogene.com
# Created Time: Mon 11 Dec 2017 02:45:29 PM CST
#########################################################################

######01  GET DOWN  ECS List
/usr/bin/sh GET_HPC_DOWN_ECS.sh 

######02  Reboot ECS List
/usr/bin/sh Reboot_ECS.sh 

echo "please wait half min to run last sub"
sleep 30

######03  Initialize  ECS 
/usr/bin/less  down_ecs.list  |awk '{print $2}' |while read l; do echo ssh  $l "'sh /root/alnode_init_2018.sh' &" ; done |sh 
