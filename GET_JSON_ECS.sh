#!/bin/bash
#########################################################################
# File Name: GET_ECS_LIST.sh
# Author: lilinji
# mail: lilinji@novogene.com
# Created Time: Mon 11 Dec 2017 11:46:30 AM CST
#########################################################################

#!/bin/bash
tcount=`aliyuncli ecs DescribeInstances --RegionId $1 --output json --filter TotalCount`
pageNum=1
cat /dev/null >ECS_IP.txt
while ((tcount>0))
do
        aliyuncli ecs DescribeInstances --RegionId $1 --PageSize 100 --PageNumber $pageNum --output json  >>ECS_JSON.txt
        let pageNum++
        let tcount-=100
done
