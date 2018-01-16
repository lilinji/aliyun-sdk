#!/bin/bash
# AliyunCli Shell Script
# Version 1.0
# Time 2015-11-26
# Author Visation

start_ecs(){
echo "Select the type of operation
   1  Start                8  Batch Start
   2  Stop                 9  Batch Stop
   3  Restart              10 Batch Restart
   4  Replace System       11 Batch Replace System
   5  Reset System         12 Batch Reset System
   6  Release              13 Batch Release
   7  Reset PassWord	   14 Batch Reset PassWord
   15 Other Select	   16 Exit
"
sleep 0.1
read -p "Please Input Select ID: " SELECT_ID

#查询实例状态
check_status(){
status=`aliyuncli ecs DescribeInstanceAttribute --InstanceId $instance --output json --filter Status |awk -F "\"" '{print $2}'`
	while [ "$status" != "Stopped" ]
	do
  	status=`aliyuncli ecs DescribeInstanceAttribute --InstanceId $instance --output json --filter Status |awk -F "\"" '{print $2}'`
  	echo "ECS Status: $status"
	sleep 2
	done
}

#启动实例
check_start(){
aliyuncli ecs StartInstance --InstanceId $instance
}

#停止实例
check_stop(){
aliyuncli ecs StopInstance --InstanceId $instance
}

#重启实例
check_reboot(){
aliyuncli ecs RebootInstance --InstanceId $instance
}

#更换系统盘
check_replace(){
aliyuncli ecs ReplaceSystemDisk --InstanceId $instance --ImageId $image
}

#查询磁盘ID
check_disk_view(){
disk=`aliyuncli ecs DescribeDisks --InstanceId $instance --output json --filter Disks.Disk[0].DiskId |awk -F "\"" '{print $2}'`
}

#重新初始化实例
check_reset(){
check_disk_view
aliyuncli ecs ReInitDisk --DiskId $disk
}

#释放
check_release(){
aliyuncli ecs DeleteInstance --InstanceId $instance
}

#修改密码
check_pass(){
aliyuncli ecs ModifyInstanceAttribute --InstanceId $instance --Password $password
}

#查询镜像
check_image(){
image=`aliyuncli ecs DescribeImages --Regionid cn-hangzhou  --ImageOwnerAlias $user --Status Available --PageSize 50 --filter Images.Image[*] |grep -E "ImageId|ImageName" |awk -F "\|" '{print $2,$3}'`
}

#创建快照
check_snapshot(){
aliyuncli ecs CreateSnapshot --DiskId $disk --SnapshotName $snapshot
}

if [[ $SELECT_ID == 1 ]]; then
	read -p 'Please Input InstanceID:' instance
        check_start

elif [[ $SELECT_ID == 2 ]]; then
        read -p 'Please Input InstanceID:' instance
        check_stop

elif [[ $SELECT_ID == 3 ]]; then
        read -p 'Please Input InstanceID:' instance
        check_reboot

elif [[ $SELECT_ID == 4 ]]; then
read -p 'Replace the System must be shut down [y/n]' key
if [ "$key" == 'y' ]; then
        read -p 'Please Input InstanceID:' instance
	check_stop
	check_status
	read -p 'Pleate Input ImageID：' image
	read -p 'Pleate Input NewPassword：' password
	check_replace
        sleep 2
        check_pass
        sleep 1
        check_start
else
        echo "Nothing to do"
fi

elif [[ $SELECT_ID == 5 ]]; then
read -p 'Rest the System must be shut down [y/n]' key
if [ "$key" == 'y' ]; then
        read -p 'Please Input InstanceID:' instance
	check_stop
	check_status
	read -p 'Pleate Input NewPassword：' password
	check_reset
	sleep 2
	check_pass
        sleep 1
        check_start
else
        echo "Nothing to do"
fi

elif [[ $SELECT_ID == 6 ]]; then
read -p '\033[1;32mWarning!!! Can not recover after release [y/n]\033[0m' key
if [ "$key" == 'y' ]; then
	read -p 'Please Input InstanceID:' instance
	check_stop
        sleep 5
        check_release
else
	echo "Nothing to do"
fi

elif [[ $SELECT_ID == 7 ]]; then
read -p 'Rest PassWord the System must be Reboot [y/n]' key
if [ "$key" == 'y' ]; then
        read -p 'Please Input InstanceID:' instance
	read -p 'Pleate Input NewPassword：' password
	check_pass
	check_reboot
else
	echo "Nothing to do"
fi

#以下是批量操作
elif [[ $SELECT_ID == 8 ]]; then
    for instance in `cat instance.txt`;
        do
        check_start
        sleep 1
        done

elif [[ $SELECT_ID == 9 ]]; then
    for instance in `cat instance.txt`;
        do
        check_stop
        sleep 1
        done

elif [[ $SELECT_ID == 10 ]]; then
    for instance in `cat instance.txt`;
        do
        check_reboot
        sleep 1
        done

elif [[ $SELECT_ID == 11 ]]; then
read -p 'Replace the System must be shut down [y/n]' key

if [ "$key" == 'y' ]; then
    for instance in `cat instance.txt`;
        do
        check_stop
        check_status
	read -p 'Pleate Input ImageID：' image
	read -p 'Pleate Input NewPassword：' password
        check_replace
        sleep 2
        check_pass
        sleep 1
        check_start
        sleep 1
        done
else
        echo "Nothing to do"
fi

elif [[ $SELECT_ID == 12 ]]; then
read -p 'Rest the System must be shut down [y/n]' key
if [ "$key" == 'y' ]; then
    for instance in `cat instance.txt`;
        do
	check_stop
	check_status
	read -p 'Pleate Input NewPassword：' password
        check_reset
	sleep 2
	check_pass
        sleep 1
        check_start
        sleep 1
	done
else
        echo "Nothing to do"
fi

elif [[ $SELECT_ID == 13 ]]; then
read -p '\033[1;32mWarning!!! Can not recover after release [y/n]\033[0m' key
if [ "$key" == 'y' ]; then
    for instance in `cat instance.txt`;
        do
        check_stop
        check_status
        check_release
        sleep 1
        done
else
        echo "Nothing to do"
fi

elif [[ $SELECT_ID == 14 ]]; then
read -p 'Rest PassWord the System must be Reboot [y/n]' key
if [ "$key" == 'y' ]; then
    for instance in `cat instance.txt`;
        do
        check_pass
        check_reboot
        sleep 1
        done
else
        echo "Nothing to do"
fi

elif [[ $SELECT_ID == 15 ]]; then
echo "Select the type of operation
   17 Query Disk ID        21 Create Snapshot
   18 Query Image ID       22 Batch Create Snapshot
   19 Batch Query Disk ID  51 Return to top
   20 Query All Image ID   51 Exit
"
sleep 0.1
read -p "Please Input Select ID: " SELECT_ID

	if [[ $SELECT_ID == 17 ]]; then
	read -p 'Please Input InstanceID:' instance
	check_disk_view
	echo "Disk ID: $disk"

	elif [[ $SELECT_ID == 18 ]]; then
	read -p "Please Input ImageName: " key
	imageid=`aliyuncli ecs DescribeImages --Regionid cn-hangzhou --ImageName $key --output json --filter Images.Image[0].ImageId |awk -F "\"" '{print $2}'`
	echo "ImageID: $imageid"
	
	elif [[ $SELECT_ID == 19 ]]; then
	read -p 'Export To File? [Y/N]' key
	if [ "$key" == 'y'  ]; then
	for instance in `cat instance.txt`;
	    do
	    check_disk_view
	    echo "$disk" >>disk.txt
	    done
	else
	for instance in `cat instance,txt`;
	    do
	    check_disk_view
	    echo "Disk ID: $disk"
	    done
	fi

        elif [[ $SELECT_ID == 20 ]]; then
	read -p 'Export To File? [Y/N]' key
	if [ "$key" == 'y'  ]; then
echo "Select the image type of operation
   1 Aliyun System Image
   2 Custom Image
   3 Market Place Image
   4 Other
   5 Exit
"
	    sleep 0.1
	    read -p "Please Input Select ID: " SELECT_ID
	    if [[ $SELECT_ID == 1 ]]; then
	    	user=system
		check_image 
		echo "$image" >System_image.txt
		sleep 1
		echo "Export To File Is OK!"
	    elif [[ $SELECT_ID == 2 ]]; then
	    	user=self
		check_image 
		echo "$image" >Self_image.txt
		sleep 1
		echo "Export To File Is OK!"
	    elif [[ $SELECT_ID == 3 ]]; then
	    	user=marketplace
		check_image
		echo "$image" >Marketplace_image.txt
		sleep 1
		echo "Export To File Is OK!"
	    elif [[ $SELECT_ID == 4 ]]; then
	    	user=others
		check_image
		echo "$image" >Others_image.txt
		sleep 1
		echo "Export To File Is OK!"
	    elif [[ $SELECT_ID == 5 ]]; then
	    	exit
	    else
	    	echo "Nothing to do"
		sleep 1
	    	start_ecs
	    fi
	else
echo "Select the image type of operation
   1 Aliyun System Image
   2 Custom Image
   3 Market Place Image
   4 Other
   5 Exit
"
	    sleep 0.1
	    read -p "Please Input Select ID: " SELECT_ID
	    if [[ $SELECT_ID == 1 ]]; then
		user=system
		check_image
		echo "$user"
		echo "$image"
	    elif [[ $SELECT_ID == 2 ]]; then
		user=self
		check_image
		echo "$user"
		echo "$image"
	    elif [[ $SELECT_ID == 3 ]]; then
		user=marketplace
		check_image
		echo "$user"
		echo "$image"
	    elif [[ $SELECT_ID == 4 ]]; then
		user=others
		check_image
		echo "$user"
		echo "$image"
	    elif [[ $SELECT_ID == 5 ]]; then
	    	exit
            else
	    	echo "Nothing to do"
		sleep 1
    	    	start_ecs
	    fi
	fi

	elif [[ $SELECT_ID == 21 ]]; then
	read -p 'Please Input InstanceID: ' instance
	check_disk_view
	read -p 'Please Input ShapshotName: ' snapshot
	check_snapshot

	elif [[ $SELECT_ID == 22 ]]; then
		for instance in `cat instance.txt`;
		do
		check_disk_view
		snapshot=ScriptsCreate
	        check_snapshot
		sleep 1
		done

	elif [[ $SELECT_ID == 50 ]]; then
	start_ecs

	elif [[ $SELECT_ID == 51 ]]; then
	exit

        else
                exit
        fi

else
    exit
fi
}
start_ecs
