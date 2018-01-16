#!/bin/bash
#########################################################################
# File Name: GET_ECS_ID.sh
# Author: lilinji
# mail: lilinji@novogene.com
# Created Time: Mon 11 Dec 2017 11:46:30 AM CST
#########################################################################

#!/bin/bash
tcount=`aliyuncli ecs DescribeInstances --RegionId $1 --output json --filter TotalCount`
pageNum=1
cat /dev/null >ECS_Descrip.txt
while ((tcount>0))
do
        aliyuncli ecs DescribeInstances --RegionId $1 --PageSize 100 --PageNumber $pageNum --output json --filter  Instances.Instance[*].InstanceName |sed '1d' | sed '$d' | sed 's/，//g' |  sed 's/"//g'| sed 's/ //g'| sed 's/,//g' >>ECS_Descrip.txt
        let pageNum++
        let tcount-=100
done
