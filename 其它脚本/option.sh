#!/bin/bash

# de hanshu disk_free;
diskspace () {
	clear
	df -k
}

# de hanshu who_logging;
whoseon () {
	clear 
	who
}

# de hanshu mem_free;
memusage () {
	clear
	cat /proc/meminfo
}

# de hanshu loggin_web;
menu () {
	clear
	echo
	# option shouming;
	echo -e "\t\t\tSys Admin Menu\n"
	# first option;
	echo -e "\t1. Display disk space"
	# two option;
	echo -e "\t2. Display logged on users"
	# free option;
	echo -e "\t3. Display memory usage"
	# zero option;
	echo -e "\t0. Exit program\n\n"
	# option;
	echo -en "\t\tEnter option: "
	read -n 1 option
}

while :
do
	menu
	case $option in
	0)
		break
	;;
	1)
		diskspace
	;;
	2)
		whoseon
	;;
	3)
		memusage
	;;
	*)
		clear
		echo "Sorry, wrong selection"
	;;
	esac

	echo -en "\n\n\t\t\tHit any key to continue"
	read -n 1 line
done
clear
