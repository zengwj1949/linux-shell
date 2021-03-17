#!/bin/bash
# Name: system_manage.sh
# Function: system_manage
# Author: Zwj
# Email: ********
# Version: 1.1
# Date: 2019-11-07 22:10:12

# Shell 小工具包；

menu () {
	cat <<-EOF
	=======================================================
	|              h. help                                |
	|              f. disk partition                      |
	|              d. filesystem mount                    |
	|              m. memory                              |
	|              u. system load                         |
	|              q. exit                                |
	=======================================================
	EOF
}

menu

manage () {
	case "$action" in
		h)
			menu
			;;
		f)
			fdisk -l
			;;
		d)
			df -Th
			;;
		m)
			free -h
			;;
		u)
			uptime
			;;
		q)
			exit 0
			;;
		'')
			;;
		*)
			echo "Input Error, Not option."
	esac
}

main () {
	while true
	do
		read -p "Please select optinon >>>: " action
		manage
	done
}

main 
