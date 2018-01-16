#!/usr/bin/env python
#-*- coding: utf-8 -*-
# Script Name    	    : LIST_HOST.py
# Author         	    : lilinji
# Created        	    : 22th November 2017
# Last Modified         : 
# Version            	: 1.0
# Modifications         :
# Description        	: Tests to see if the directory testdir exists, if not it will create the directory for you
import sys
import os
import argparse
import json
import time
import bisect
import re
#import encoding
################传参程序
reload(sys)
sys.setdefaultencoding('utf8')
print "程序名：", sys.argv[0]
parser = argparse.ArgumentParser(description='manual to this script')
parser.add_argument('-f','--file', type=str, default='sample.txt', help="Add File temp")
parser.add_argument('-p','--project', type=str, default='aliyun', help="Add queue project")
parser.add_argument('-n','--name', type=str, default='alnode', help="name ")
parser.add_argument('-u','--user', type=str, default='lilinji', help="Add Usr")
help = 'python xxx.py -f  -p -u '
parser.add_argument('-v','--version', type=str, help=help)
args = parser.parse_args() #参数赋值
if args.version:
    print "verbosity turned on"
########################
os.getcwd()
#os.getcwd()
#os.chdir()
#print os.getcwd()
############# TIME 
s = time.ctime()
print (s)
dict1={}
dict2={}
dict3={}
################ 读取文件 sample.txt

with open('hosts', 'r') as f1:
	list3 = f1.readlines()
	for line in list3:
		 line = line.strip('\n')
#			line4 = re.match( r'(.*)\s(.*)', line, re.M|re.I)
		 line4 = re.split('\s+', line, re.M|re.I)# split 空格 输出数组行
			#dict line4
			# dic(line4[0]) = line4[1]
		 dict1[line4[1]] = line4[0]

	f1.close()
#print (dict1.iterkeys())  
#########迭代
#LINE = ([line.rstrip()for line in open('host.txt','r')])
#3I=iter(LINE)
#3print next(I)
#print next(I)
#for line in LINE:
#         print line
#print LINE
with open('ECS_IP_ID.txt', 'r') as f1:
     list11 = f1.readlines()
     for line in list11:
          line = line.strip('\n')
#           line4 = re.match( r'(.*)\s(.*)', line, re.M|re.I)
          line12 = re.split('\s+', line, re.M|re.I)# split 空格 输出数组行
              #dict line4
             # dic(line4[0]) = line4[1]
          dict3[line12[0]] = line12[1]
 
     f1.close()

with open ('a.txt','r') as f1:
	LINE_HOST=f1.readlines()
#        print LINE_HOST
	for line in LINE_HOST:
            line = line.strip('\n')
	    #print line
            line5=re.match(r'(.*)\s+(.*)\s+(.*)\s+\-', line)
            #print line5
            if line5: 
                    # 使用Match获得分组信息 
                line7=re.split('\s+', line)
                dict2[line7[0]] = line7
                               
                               ### 输出 ### 

####################################
head = 'auto_userone'###全局变量
name = 'Jordy'###全局变量
####################################
############ 写文件
def WriteToFileUsePrint():
    saveout = sys.stdout	
    fd = open('sample.txt', 'w')
    sys.stdout = fd
    print "head:"+head+'\n',"name:"+name
    sys.stdout = saveout
    fd.close()

def WriteToFile():
    with open('sample.txt', 'a+') as fd:
        fd.write("head:"+head+'\n' + "name:"+name+'\n' + "sex:"+sex+'\n' + "hobby:"+hobby+'\n')
        fd.close()
#print list(dict1.itervalues())
############# Hash 字典 写入
def WriteToFileUsePrint():
    saveout = sys.stdout
    fd = open('down_ecs.list', 'w')
    sys.stdout = fd
    for key,value in sorted (dict2.items()):
#        print 'key is %s,value is %s'%(key,value)
#        print list(dict1.itervalues())
            if dict1[key]: 
                    print dict1[key]+'\t'+key+'\t'+str(dict3[dict1[key]])
    sys.stdout = saveout
    fd.close()
#for key,value in sorted (dict3.items()):
#        print key

if __name__ == '__main__':
       print '''hello word'''
WriteToFileUsePrint()
os.system('chmod 755 down_ecs.list')
for i in range(10):
    sys.stdout.write(str(i+1)+"0%"+"^^"+"\n")  # 调用sys在屏幕输出
    sys.stdout.flush()  # 用flush()刷新，没有这句还是会等到缓存满了或者运行到最后了才会一次性全部显示出来
    time.sleep(0.2)  # 停顿0.2然后继续
sys.stdout.write("done")
