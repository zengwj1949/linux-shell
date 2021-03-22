
#!/usr/bin/env bash
# Function: Backup Mysql Data;
# Author: Zwj;
# Email: *****@***;
# Date: 2021-01-28;
# Version: 1.0

set -e

# Mariadb hosts;
MYSQL_IP="10.1.1.33"
MYSQL_USER="root"
MYSQL_PASS="u6GZfmBTTF"

BACK_DIR="/data/python-down/backup-mysql/$(date +%F)"
BACK_LOG="/data/python-down/backup-mysql/back.log"
BACK_TIME=$(date +%F-%H%M)
BACK_DATAS="asi bat mmp libra"
BACK_COMMAND="/usr/bin/mysqldump -h${MYSQL_IP} -P32675 -u${MYSQL_USER} -p${MYSQL_PASS} -q -R -E -F --default-character-set=utf8mb4 --triggers --single-transaction --master-data=2"

[ -d $BACK_DIR ] || mkdir $BACK_DIR
cd $BACK_DIR
for data in $BACK_DATAS; do
        $BACK_COMMAND -B $data | gzip > ${BACK_TIME}_$data.sql.gz
done

if [ $? -eq 0 ]; then
        echo "=====================================" >> $BACK_LOG
        echo -e "$BACK_TIME: MySQL backup is Successful.\n" >> $BACK_LOG
else
        echo "=====================================" >> $BACK_LOG
        echo -e "$BACK_TIME: MySQL backup is Fail.\n" >> $BACK_LOG
fi

sleep 3
# rm 7 days ago backup file;
find /data/python-down/backup-mysql/ -type d -mtime +7 | xargs rm -fr