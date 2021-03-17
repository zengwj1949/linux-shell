#!/bin/bash
# Name: case_jumpserver.sh
# Function: case_jumpserver
# Author: Zwj
# Email: ********
# Version: 1.1
# Date: 2019-11-07 16:56:53

################################################################################
#                                                                              #
#                                                                              #
#                                 SHELL 堡垒机                                 #
#                                                                              #
#                                                                              #
################################################################################

#set -e

# 此脚本需要放在跳板机用户家目录下，然后在 .bash_profile 文件中写入脚本的绝对路径；

trapper () {
	trap '' INT QUIT TSTP TERM HUP
}


host_list () {
	cat <<-EOF
=================== Host List ===================

        1) Pro_Redis:172.16.1.246
        2) Pro_Tomcat:172.16.1.252
        3) Test_Tomcat:172.16.1.254

=================================================
	EOF
}

host_login () {
	case "$1" in
		1)
			ssh $USER@172.16.1.246
			;;
		2)
			ssh $USER@172.16.1.252
			;;
		3)
			ssh $USER@172.16.1.254
	esac
}

main () {
	while true
	do
		trapper
		clear
		host_list
		read -p "Please select >>>: " num
		host_login $num
	done
}

main





