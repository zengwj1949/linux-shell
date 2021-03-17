#!/bin/bash
# Name: get_hostlist.sh
# Function: get_hostlist
# Author: Zwj
# Email: ********
# Version: 1.1
# Date: 2019-11-09 14:18:54

# 此脚本旨在获取当前网络环境中存活的计算机列表;并向这些主机推送公钥，实现无密钥登陆；

set -e
# Install expect;
sudo rpm -qa | grep expect && echo "expect is installed." || sudo yum install expect -y

# Create hostlist file;
file=/data/get_hostlist.txt
[ -f $file ] || mkdir -pv $file
# Empty file;
sudo chown -R test.test $file
> $file

# Create public key and private key;
if [ ! -f ./.ssh/id_rsa ]
then
	ssh-keygen -P "" -t rsa -f ~/.ssh/id_rsa \
	&& echo "Pub_key is ok."
fi
sleep 2

#######################################################################
# 1 Which hosts exist;                                                #
# 2 Input host ip to file;                                            #
# 3 Push the public key to the remote host;                           #
#######################################################################

# Import password file;
. p.conf
for n in {246,252,254,257,222}
do
	{
	ip="172.16.1.$n"
	ping -c1 -W1 $ip &> /dev/null
	if [ $? -eq 0 ]
	then
		echo "$(date +"%F %T")   $ip" >> $file
		/usr/bin/expect <<-EOF
		set timeout 10
		spawn ssh-copy-id -i ./.ssh/id_rsa.pub $ip
		expect {
			"yes/no" { send "yes\r"; exp_continue }
			"password:" { send "$pass\r" }
		} 
		expect eof
		EOF
	fi
	} &
done
wait
echo "Finish"
