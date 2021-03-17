#!/bin/bash
# Author: Mr Z
# Functions: Check_Services
# Date: 2019-01-03
# Email: *******@lantu.com
# Version: 1.1

EXIT_N=65
HOST=Kooche_prod
IP=$(ifconfig eth0 | awk -F '[ ]+' '/inet/{print $3}' | awk -F : '{print $2}')
DATE_N=$(date +"%F %H:%M")
MAIL_LIST="2962372861@qq.com zengweijun@szlantu.net everyljt@163.com"
K_URL=https://www.kooche.cn/

CHECK_FDISK () {
FREE_FDISK=$(df -Th | awk 'NR==2' | awk '{print $5}' | awk -F 'G' '{print $1}')
if [ ${FREE_FDISK} -le 50 ]
then
	echo "
	Date: ${DATE_N}
	Host: ${HOST}_${IP}
	Free_Fdisk: ${FREE_FDISK}G
	" | mail -s "Fdisk Monitor" ${MAIL_LIST}
fi
}

CHECK_CPU () {
CPU_US=$(vmstat | awk 'NR==3 {print $13}')
CPU_SYS=$(vmstat | awk 'NR==3 {print $14}')
CPU_LOAD=$(($CPU_US+$CPU_SYS))
if [ ${CPU_LOAD} -ge 60 ]
then
	echo "
	Date: ${DATE_N}
	Host: ${HOST}_${IP}
	Problem: CPU utilization ${CPU_LOAD}
	" | mail -s "CPU Monitor" ${MAIL_LIST}
fi
}

CHECK_MEMORY () {
# FREE_MEM=$(free -m | awk 'NR==2 {print $4}')
FREE_MEM=$(free -m | awk 'NR==3 {print $4}')
if [ ${FREE_MEM} -le 1000 ]
then
	echo "
	Date: ${DATE_N}
	Host: ${HOST}_${IP}
	Internal storage: free is ${FREE_MEM}
	" | mail -s "Internal storage" ${MAIL_LIST}
fi
}

CHECK_KOOCHE-APP () { 
KOOCHE_APP_SERVICE="app-kooche-tomcat"
KOOCHEAPP_PID=$(ps -ef | grep "app-kooche-tomcat" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHEAPP_PID}" ]
then
	echo "
	Date: ${DATE_N}
	Host: ${HOST}_${IP}
	Problem: ${KOOCHE_APP_SERVICE} is down.
	" | mail -s "${KOOCHE_APP_SERVICE} status" ${MAIL_LIST} 
fi
}

CHECK_KOOCHE-CLIENT () {
KOOCHE_CLIENT_SERVICE="client-kooche-tomcat"
KOOCHECLIEN_PID=$(ps -ef | grep "client-kooche-tomcat" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHECLIEN_PID}" ]
then
	echo "
	Date: ${DATE_N}
        Host: ${HOST}_${IP}
	Problem: ${KOOCHE_CLIENT_SERVICE} is down.
	" | mail -s "${KOOCHE_CLIENT_SERVICE} status" ${MAIL_LIST}
fi
}

CHECK_KOOCHE-MANAGER () {
KOOCHE_MANAGER_SERVICE="manager-kooche-tomcat"
KOOCHEMANAGER_PID=$(ps -ef | grep "manager-kooche-tomcat" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHEMANAGER_PID}" ]
then
	echo "
	Date: ${DATE_N}
        Host: ${HOST}_${IP}
	Problem: ${KOOCHE_MANAGER_SERVICE} is down.
	" | mail -s "${KOOCHE_MANAGER_SERVICE} status" ${MAIL_LIST}
fi
}

CHECK_KOOCHE-STORE () {
KOOCHE_STORE_SERVICE="store-kooche-tomcat"
KOOCHESTORE_PID=$(ps -ef | grep "store-kooche-tomcat" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHESTORE_PID}" ]
then
	echo "
	Date: ${DATE_N}
        Host: ${HOST}_${IP}
        Problem: ${KOOCHE_STORE_SERVICE} is down.
        " | mail -s "${KOOCHE_STORE_SERVICE} status" ${MAIL_LIST}
fi
}

CHECK_KOOCHE-WAP () {
KOOCHE_WAP_SERVICE="wap-kooche-tomcat"
KOOCHEWAP_PID=$(ps -ef | grep "wap-kooche-tomcat" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHEWAP_PID}" ]
then
	echo "
	Date: ${DATE_N}
        Host: ${HOST}_${IP}
        Problem: ${KOOCHE_WAP_SERVICE} is down.
        " | mail -s "${KOOCHE_WAP_SERVICE} status" ${MAIL_LIST}
fi
}

CHECK_KOOCHE-API () {
KOOCHE_API_SERVICE="kooche-api-service"
KOOCHEAPI_PID=$(ps -ef | grep "kooche-api-service" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHEAPI_PID}" ]
then
	echo "
	Date: ${DATE_N}
        Host: ${HOST}_${IP}
        Problem: ${KOOCHE_API_SERVICE} is down.
        " | mail -s "${KOOCHE_API_SERVICE} status" ${MAIL_LIST}
fi
}

CHECK_KOOCHE-STORE-RPC () {
KOOCHE_STORE_RPC_SERVICE="kooche-store-rpc-service"
KOOCHE_STORERPC_PID=$(ps -ef | grep "kooche-store-rpc-service" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHE_STORERPC_PID}" ]
then
	echo "
	Date: ${DATE_N}
        Host: ${HOST}_${IP}
        Problem: ${KOOCHE_STORE_RPC_SERVICE} is down.
        " | mail -s "${KOOCHE_STORE_RPC_SERVICE} status" ${MAIL_LIST}
fi
}

CHECK_KOOCHE-SEARCH () {
KOOCHE_SEARCH_SERVICE="kooche-search-service"
KOOCHESEARCH_PID=$(ps -ef | grep "kooche-search-service" | grep -v grep | awk '{print $2}')
if [ -z "${KOOCHESEARCH_PID}" ]
then
	echo "
	Date: ${DATE_N}
        Host: ${HOST}_${IP}
        Problem: ${KOOCHE_SEARCH_SERVICE} is down.
        " | mail -s "${KOOCHE_SEARCH_SERVICE} status" ${MAIL_LIST}
fi
}

CHECK_URL () {
wget -T 5 --spider -t 3 ${K_URL} &> /dev/null
if [ $? -ne 0 ]
then
	echo "
        Date: ${DATE_N}
        Host: ${HOST}_${IP}
        Problem: ${K_URL} is down.
        " | mail -s "${K_URL} status" ${MAIL_LIST}
else
	echo "${K_URL} is ok." &> /dev/null
fi
}

CHECK_CPU;
CHECK_FDISK;
CHECK_MEMORY;
CHECK_KOOCHE-APP;
CHECK_KOOCHE-CLIENT;
CHECK_KOOCHE-MANAGER;
CHECK_KOOCHE-STORE;
CHECK_KOOCHE-WAP;
CHECK_KOOCHE-API;
CHECK_KOOCHE-STORE-RPC;
CHECK_KOOCHE-SEARCH;
CHECK_URL;
	






