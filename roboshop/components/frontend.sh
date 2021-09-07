#!/bin/bash

source components/common.sh

Print "To Install Nginx\t"
yum install nginx -y &>>$LOG
Stats_Check $?

Print "Download frontend archive"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
Stats_Check $?


Print "Extract Frontend Archive"
rm -rf /usr/share/nginx/* && cd /usr/share/nginx && unzip -o  /tmp/frontend.zip &>>$LOG && mv frontend-main/* . &>>$LOG && mv static html &>>$LOG
Stats_Check $?


Print "Copy Nginx RoboShop Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
Stats_Check $?

Print "Update Nginx RoboShop Config"
sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/'  /etc/nginx/default.d/roboshop.conf &>>$LOG
Stats_Check $?


Print "Restart Nginx\t\t"
systemctl restart nginx &>>$LOG && systemctl enable nginx &>>$LOG
Stats_Check $?

# rm -rf frontend-master static README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
#Finally restart the service once to effect the changes.

#systemctl enable nginx 
#systemctl start nginx 


# systemctl restart nginx 

