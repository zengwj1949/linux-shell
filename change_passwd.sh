#!/bin/bash
# Name: change_passwd.sh
# Function: change_passwd
# Author: Zwj
# Email: ********
# Version: 1.1
# Date: 2019-11-10 01:17:12

# This script is change remote hosts passwd;

# Execution of this script presupposes that the key has been pushed to the remote server;
hostlist=/data/hostlist.txt

read -p "Please Input a New Password: " pass

for ip in $(cat $hostlist)
do
	{
	ping -c1 -W1 $ip &> /dev/null
	if [ $? -eq 0 ]
	then
		ssh $ip "echo $pass | passwd --stdin root" 
		if [ $? -eq 0 ]
		then
			echo "$ip" >> sucessful_$(date +%F).txt
		else
			echo "$ip" >> fail_$(date +%F).txt
		fi
	else
		echo "$ip" >> nonetwork_$(date +%F).txt
	fi
	} &
done
wait
echo "Finish......"
