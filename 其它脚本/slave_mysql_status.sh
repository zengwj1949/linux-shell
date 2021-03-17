#!/bin/bash

/usr/bin/mysql -e 'show slave status\G' | grep -E "Slave_IO_Running|Slave_SQL_Running" | awk '{print $2}' | grep -c Yes
