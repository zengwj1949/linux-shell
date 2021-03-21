# /bin/bash
# Name: Jenkins_2.164_1 script
# Functions: Jenkins_Dploy;
# Author: Mr Zeng;
# Email: *****@qq.com;
# Version: 1.1

set -e

# This script is jenkins deploy and jenkins rollack;

case $status in
    deploy)
	echo "Status: $status."
	# backup war pachage dir;
    	path="$WORKSPACE/backup/${BUILD_NUMBER}"
    	if [ -d ${path} ]
    	then
    		echo "This backup dir is exists."
    	else
    		mkdir -pv ${path}
    	fi
	# backup war;
        cp -f ${WORKSPACE}/target/*.war $path \
        && echo "This ${BUILD_NUMBER} backup is ok."
    ;;  
    rollback)
    	echo "Status: $status."
        echo "Version: $version"
	# to backup dir,cp backup_file to target_dir;
        cd $WORKSPACE/backup/$version \
        && cp -f *.war $WORKSPACE/target
    ;;
    *)
    	exit;
    ;;
esac
        
