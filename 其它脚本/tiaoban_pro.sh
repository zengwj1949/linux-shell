#!/bin/bash
# Name: tiaoban;
# Function: tiaoban;
# Author: Mr Z;
# Email: *********@lantu.com;
# Version: 1.1;
# Date: 1.1;

# 此脚本存放在 /etc/profile.d 目录下；
[ $UID -ne 0 ] && [ $UID -ne 500 ] \
&& bash /data/tiaoban.sh

