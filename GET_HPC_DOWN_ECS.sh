#!/bin/bash
#########################################################################
# File Name: GET_HPC_DOWN_ECS.sh
# Author: lilinji
# mail: lilinji@novogene.com
# Created Time: Mon 11 Dec 2017 02:03:39 PM CST
#########################################################################

/usr/bin/sh GET_ECS_ID.sh
/usr/bin/sh GET_ECS_IP.sh 
paste -d "\t" ECS_IP.txt ECS_ID.txt  |awk -F "\t" '{if($1!="") print $0}' >ECS_IP_ID.txt
/opt/gridengine/bin/linux-x64/qhost |sed '1,3d' >a.txt
less /etc/hosts |grep  -v '#' >hosts
/usr/bin/python LIST_HOST.py
