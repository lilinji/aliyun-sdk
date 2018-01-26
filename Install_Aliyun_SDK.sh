#!/usr/bin/env bash
# Copyright 2015, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Note:
# This file is maintained in the install-aliyun-sdk repository.
# https://github.com/lilinji/aliyun-sdk/blob/master/Install_Aliyun_SDK.sh 
# If you need to modify this file, update the one in the install-aliyun-sdk
# repository and then update this file as well. The purpose of this file is to
# prepare the host and then execute all the tox tests.
#

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
