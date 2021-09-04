#!/bin/bash
source components/common.sh

Print "Install YUM Util and DOWNLOAD Redis Repos"


yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm  -y &>>$LOG

Stats_Check $?

Print "Setup Redis Repos\t\t\t"

yum-config-manager --enable remi &>>$LOG

Stats_Check $?

Print "Install Redis Repos\t\t\t"

yum install redis -y &>>$LOG
Stats_Check $?


Print "Configure Redis Listen Address\t\t"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
Stats_Check $?

Print "Start Redis Service\t\t\t"

systemctl enable redis &>>$LOG && systemctl start redis &>>$LOG
Stats_Check $?