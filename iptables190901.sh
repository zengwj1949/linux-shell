#!/bin/bash
# Name: Iptables.sh
# Functions: Iptables
# Author: Mr Zeng
# Email: *****@lantu.com
# Version: 1.1

set -e

iptables -F
iptables -F -t nat
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dport 22,80,443,2222,8080 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT

# Ping Other and me;
#iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A INPUT -p icmp --icmp 8 -j ACCEPT
iptables -A INPUT -p icmp --icmp 0 -j ACCEPT

# yum
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
service iptables save
