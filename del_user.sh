#!/bin/bash
# Name: del_user
# Function: Delete_User;
# Author: Zwj
# Email: ********
# Version: 1.1
# Date: 2019-11-06 15:24:28

read -p "Please input a username: " user

id $user &> /dev/null
if [ $? -ne 0 ]
then
	echo "No This user."
	exit 1
fi

read -p "Are your sure delete user? [y|n]: " action
if [ "$action" != "y" ]
then
	echo "Ok.Bye Bye!"
	exit 2
fi

userdel -r $user && echo "$user is delete."
