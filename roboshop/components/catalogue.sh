#!/bin/bash

source components/common.sh

Print "Installing NodeJS"

yum install nodejs make gcc-c++ -y 
Stats_Check $?

Print "Adding RoboShop User"

useradd roboshop &>>$LOG
Stats_Check $?

Print "Downloading Catalogue Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
Stats_Check $?

Print "Extracting Catalogue"

cd /home/roboshop
unzip /tmp/catalogue.zip &>>$LOG

mv catalogue-main catalogue
Stats_Check $?

cd /home/roboshop/catalogue


npm install &>>$LOG


NOTE: We need to update the IP address of MONGODB Server in systemd.service file
Now, lets set up the service with systemctl.

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue