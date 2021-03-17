#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage `basename $0` script-name"
	exit 99
fi
cat > $1 << end
#!/usr/bin/env bash

#########################################################
# Name: $1
# Date: `date "+%F %T"`
# Author: zwj
# Mail: 2962372861@qq.com
# Function: $1
# Version: 1.1
#########################################################

set -e


end
vim +14 $1
