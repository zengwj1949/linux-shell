# /bin/bash
# Name: Jenkins_2.164_2 script
# Functions: Jenkins_Dploy;
# Author: Mr Zeng;
# Email: *****@qq.com;
# Version: 1.1

set -e

keepfile_n=20
# backup dir;
file_dir="$WORKSPACE/backup"
date=$(date +"%Y%m%d-%H%M%S")

cd ${file_dir}
# backup war pachage's number;
file_n=$(ls -l | grep "^d" | wc -l)

while (( ${file_n} > ${keepfile_n} ))
do
    oldfile=$(ls -rt | head -1)
    echo $date "Delete File: "${oldfile}
    rm -fr ${file_dir}/${oldfile}
    ((file_n--))
done

