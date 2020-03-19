#!/bin/bash

set -e

JAVA8_HOME=/usr/jdk1.8.0_91/
JAVA7_HOME=/usr/jdk1.7.0_79/
JAVA6_HOME=/usr/jdk1.6.0_27/
JHOME=/usr/

function Survivor0 { 
$JHOME/bin/jstat -gcutil $pid | awk 'NR==2 {print $1}'
} 
function Survivor1 { 
$JHOME/bin/jstat -gcutil $pid | awk 'NR==2 {print $2}'
} 
function Eden { 
$JHOME/bin/jstat -gcutil $pid | awk 'NR==2 {print $3}'
} 
function Old { 
$JHOME/bin/jstat -gcutil $pid | awk 'NR==2 {print $4}'
} 
function Perm { 
$JHOME/bin/jstat -gcutil $pid | awk 'NR==2 {print $5}'
} 
function Metaspace { 
$JHOME/bin/jstat -gcutil $pid | awk 'NR==2 {print $5}'
} 


process=$(ps -ef | grep "$2" | grep -v 'jstat' | grep -v 'grep' | awk 'NR==1 {print $0}')
pid=$(echo $process | awk '{print $2}')

java8=$(echo $process | grep jdk1.8)
java7=$(echo $process | grep jdk1.7)
java6=$(echo $process | grep jdk1.6)

if [ ! -z "$java8" ];then
    JHOME=$JAVA8_HOME
elif [ ! -z "$java7" ];then
    JHOME=$JAVA7_HOME
elif [ ! -z "$java6" ];then
    JHOME=$JAVA6_HOME
fi


$1 "$2"
