#!/bin/bash
# Name: Tiaoban;
# Function: Tiaoban;
# Author: Mr Zeng;
# Email: ******@lantu.com;
# Version: 1.1;
# Date: 2019-04-19;


function trapper () {
    trap "INT QUIT TSTP TERM HUP"
}

function menu () {
	cat <<-EOF
=============== Host List ===============
    1) P2p:172.29.0.191
    2) Test:192.168.1.189
    3) exit
=========================================
	EOF
}

function host () {
    case "$1" in
        1)
            ssh $USER@172.29.0.191
    ;;
        2)
            ssh $USER@192.168.1.189
    ;;
        3|*)
            exit
    ;;
    esac
}

function main () {
    while true
    do
        trapper
        clear
        menu
        read -p "Please select >>>: " num
        host $num
    done
}
main
