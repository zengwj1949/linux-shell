#!/bin/bash
# Name: tcp_status;
# Author: Mr Z;
# Function: tcp_status;
# Email: 999@qq.com;
# Date: 20.03.17
# Version: 1.0

set -e

ESTAB () {
	ss -an | grep :80 | grep -i "ESTAB" | wc -l
}

TIME_WAIT () {
	ss -an | grep :80 | grep -i "TIME_WAIT" | wc -l
}

SYN_SENT () {
	ss -an | grep :80 | grep -i "SYN_SENT" | wc -l
}

SYN_RECV () {
	ss -an | grep :80 | grep -i "SYN_RECV " | wc -l
}

COLSE () {
	ss -an | grep :80 | grep -i "COLSE " | wc -l
}

$1
