#!/bin/bash

####install git
yum install git -y 

INFLAMMATORY=`lsb_release -a |grep 'CentOS Linux release 7'` 
#SWAPPINESS=(sysctl -a | grep vm.swappiness | awk -F ' = ' '{print \$2}')
echo $INFLAMMATORY
if [ "$INFLAMMATORY" ];then 
     echo -e "I have never like anyone who ram a production ready Arch Linux
Anything... install Centos7 Aliyun SDK...
"
     sleep 3
      git clone https://github.com/lilinji/hpc-sdk.git
else
     echo -e "I have never meet anyone who ram a production ready Arch Linux 
Anything... And you think  install Centos6 Aliyun SDK...
"    
     sleep 2
      git clone https://github.com/lilinji/hpc-sdk2.git
     sleep 2
fi
