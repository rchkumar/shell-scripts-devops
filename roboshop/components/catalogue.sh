#!/bin/bash

source components/common.sh

Print "Installing NodeJS"

yum install nodejs make gcc-c++ -y  &>>$LOG
Stats_Check $?

Print "Adding RoboShop User"
id roboshop &>>$LOG

if [ $? -eq 0 ];
then
echo " User already there , so skipping" &>>$LOG
else
useradd roboshop &>>$LOG
fi

Stats_Check $?

Print "Downloading Catalogue Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
Stats_Check $?

Print "Extracting Catalogue"

cd /home/roboshop
rm -rf catalogue  && unzip /tmp/catalogue.zip &>>$LOG && mv catalogue-main catalogue
Stats_Check $?

Print "Download NodeJS Dependencies"

cd /home/roboshop/catalogue

npm install --unsafe-perm &>>$LOG

Stats_Check $?

chown roboshop:roboshop -R /home/roboshop

Print "Update SystemD Service"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service
Stats_Check $?

Print "Setup SystemD Service"

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service && systemctl daemon-reload && systemctl start catalogue &>>$LOG && 
systemctl enable catalogue &>>$LOG
Stats_Check $?
