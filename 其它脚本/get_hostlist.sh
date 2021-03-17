#!/bin/bash
# Name: get_hostlist.sh
# Function: get_hostlist
# Author: Zwj
# Email: ********
# Version: 1.1
# Date: 2019-11-09 14:18:54

# 此脚本旨在获取当前网络环境中存活的计算机列表;

set -e

file=/data/get_hostlist.txt
[ -f $file ] || mkdir -pv $file

> /data/get_hostlist.txt

for n in {246,252,254,257,222}
do
	{
	ip="172.16.1."
	ping -c1 -W1 $ip$n &> /dev/null
	if [ $? -eq 0 ]
	then
		echo "$(date +"%F %T")   $ip$n" >> $file
	fi
	} &
done
wait

