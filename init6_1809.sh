#!/bin/bash
# Function: system_init;
# Date: 20-01-01
# Author: Mr Zeng;
# Version: 1.1

#########################################################################
#                                                                       #
# 1. Install Linux;                                                     #
# 2. Use this script init system;                                       # 
#                                                                       # 
#########################################################################
 
set -e

# Please use root;
if [[ "$(whoami)" != "root" ]]  
then
	echo "Please use root to run this script."
	exit 1
fi

echo -e "\033[31m 这是CentOS 6初始化脚本，仅在初次安装系统时使用，请慎重运行! Press ctrl+c to cancel \033[0m"
sleep 10

# Install devel tools and epel;	
yum install -y epel*
yum clean all && yum makecache
yum -y groupinstall "Development tools"
yum install -y lrzsz sysstat elinks wget net-tools bash-completion tree nmap vim lsof dos2unix nc telnet ntp rng-tools psmisc gcc gcc-c++ unzip ntp
yum -y update

# Time synchronization;
/usr/bin/update -u ntp.aliyun.com && /sbin/hwclock -w
sleep 3

# Change File descriptor
cat >> /etc/security/limits.conf << EOF
* soft nproc 65534
* hard nproc 65534
* soft nofile 65534
* hard nofile 65534
EOF
sed -i 's/1024/65534/' /etc/security/limits.d/90-nproc.conf
echo "ulimit -SHn 65534" >> /etc/profile

# Change kernel parameters;
cat >> /etc/sysctl.conf << EOF
#net.ipv4.ip_forward = 1 
net.ipv4.tcp_fin_timeout = 20
net.ipv4.tcp_tw_reuse= 1
net.ipv4.tcp_tw_recycle= 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 4000 65000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_syn_retries= 2
net.ipv4.tcp_synack_retries= 2
net.core.somaxconn = 16384
net.core.netdev_max_backlog = 16384
EOF
/sbin/sysctl -p

# Disabled selinux and Ctrol+Alt+del;
sed -i 's/start on control-alt-delete/#start on control-alt-delete/' /etc/init/control-alt-delete.conf
sed -i 's@exec /sbin/shutdown -r now "Control-Alt-Delete pressed"@#exec /sbin/shutdown -r now "Control-Alt-Delete pressed"@' /etc/init/control-alt-delete.conf
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Stop and Disable iptables;
service iptables stop
chkconfig iptables off

# Change default sshd parameters;
cp -a /etc/ssh/sshd_config /etc/ssh/sshd_config.old
sed -i '/^#Port/ a\Port 60000' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

reboot
