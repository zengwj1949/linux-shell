#!/bin/bash
# Function: system_init;
# Date: 19-06-04;
# Author: Mr Zeng;
# Version: 1.1 1.2 1.3

# Please use ROOT;
if [[ "$(whoami)" != "root" ]];
then
    echo "Please run this script as root."
    exit 1
fi

echo -e "\033[31m 这是CentOS 7初始化脚本，仅在初次安装系统时使用，请慎重运行! Press ctrl+c to cancel \033[0m"
sleep 10

# Install devel tools and epel;
cd /usr/local/src \
&& wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
&& rpm -ivh epel-release-latest-7.noarch.rpm
yum clean all && yum makecache
yum -y groupinstall "Development tools"
yum install -y lrzsz sysstat elinks wget net-tools bash-completion tree nmap vim lsof dos2unix nc telnet ntp rng-tools psmisc gcc gcc-c++ unzip ntp
yum -y update

# Time synchronization;
/sbin/ntpdate -u ntp.aliyun.com && /sbin/hwclock -w
sleep 3

# 修改用户最大进程数、最大能打开的文件描述符；
cat >> /etc/security/limits.conf << EOF
* soft nproc 65534
* hard nproc 65534
* soft nofile 65534
* hard nofile 65534
EOF
sed -i 's/4096/65534/' /etc/security/limits.d/20-nproc.conf

# /etc/security/limits.conf的配置，只适用于通过PAM认证登录用户的资源限制；
# 它对systemd的service的资源限制不生效。因此登录用户的限制，通过/etc/security/limits.conf与/etc/security/limits.d下的文件设置即可。
# 对于systemd service的资源设置，则需修改全局配置，全局配置文件放在/etc/systemd/system.conf和/etc/systemd/user.conf，
# 同时也会加载两个对应目录中的所有.conf文件/etc/systemd/system.conf.d/*.conf和/etc/systemd/user.conf.d/*.conf。system.conf是系统实例使用的，user.conf是用户实例使用的。
sed -i '/^#DefaultLimitNOFILE=/aDefaultLimitNOFILE=65534' /etc/systemd/system.conf
sed -i '/^#DefaultLimitNPROC=/aDefaultLimitNPROC=65534' /etc/systemd/system.conf

# 修改内核参数；
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

# Disable selinux;
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld

# Stop 'Ctrl+Alt+Del' reboot;
mv /usr/lib/systemd/system/ctrl-alt-del.target /tmp
init q

# Change default sshd parameters;
cp -a /etc/ssh/sshd_config /etc/ssh/sshd_config.old
sed -i '/^#Port/ a\Port 60000' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

reboot
