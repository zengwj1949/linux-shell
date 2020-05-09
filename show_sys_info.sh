#!/bin/bash
# Name: show_sys_info.sh
# Function: show_sys_info
# Author: Zwj
# Email: ********
# Version: 1.1
# Date: 2020-05-09 13:16:50

#############################################################
#
#                       系统性能分析脚本
#
#############################################################

set -e

EXIT_N=88

# Install soft;
rpm -q bc &> /dev/null || {
echo "Install bc......" \
&& yum -y install bc
}

[ "$UID" -ne 0 ] && { 
echo "Please usage admin user." \
&& exit $EXIT_N
}

HOST_INFO () {
	echo "hostname: $(hostname)          IP: $(hostname -I)"
}

CPU_USE () {
	lscpu | egrep "CPU|Core" | awk 'NR==4 {print $0}'
	lscpu | egrep "CPU|Core" | awk 'NR==2 {print $0}'
	uptime | awk -F ':' '{print $5}'
}

CPU_TOP5 () {
	ps aux --sort=-%cpu | head -6
}

MEM_USE () {
	free -h | awk 'NR==2{print $0}' | awk '{print "total:",$2,"userd:",$3,"free:",$4}'
}

MEM_TOP5 () {
	ps aux --sort=-%mem | head -6
}

DISK_USE () {
	df -Th | grep "/dev/mapper/cl-root" | awk '{print "/"," ", "available:",$5,"userd:",$6}'
}

NETWORK_USE () {
	local net_card=ens33
	RX_bytes=$(cat /proc/net/dev | grep $net_card | awk '{print $2}')
        TX_bytes=$(cat /proc/net/dev | grep $net_card | awk '{print $10}')

        sleep 10

        RX_bytes_later=$(cat /proc/net/dev | grep $net_card | awk '{print $2}')
        TX_bytes_later=$(cat /proc/net/dev | grep $net_card | awk '{print $10}')

        ### Mb=B*8/1024/1024
   
        speed_RX=`echo "scale=2;(${RX_bytes_later}-${RX_bytes})*8/1024/1024/10" | bc`
        speed_TX=`echo "scale=2;(${TX_bytes_later}-${TX_bytes})*8/1024/1024/10" | bc`

        printf "%-3s %-3.1f %-10s %-4s %-3.1f %-4s\n" IN: ${speed_RX} Mb/s OUT: ${speed_TX} Mb/s
}

NETWORK_TOP5 () {
	echo network_top5
}
echo -e "
\033[40;33m================== Host_info ==================\033[0m
$(HOST_INFO)

\033[40;33m================== Cpu_load(1,5,15) ==================\033[0m
$(CPU_USE)  

\033[40;33m================== Cpu_top5 ==================\033[0m
$(CPU_TOP5)

\033[40;33m================== Mem_info ==================\033[0m
$(MEM_USE)  

\033[40;33m================== Mem_top5 ==================\033[0m
$(MEM_TOP5)

\033[40;33m================== Network_use ==================\033[0m
$(NETWORK_USE)       

\033[40;33m================== Disk_use ==================\033[0m
$(DISK_USE)   
"
