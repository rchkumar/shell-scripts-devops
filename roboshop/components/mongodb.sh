#!/bin/bash
source components/common.sh


Print "Setting up Mongo DB Repo:"


echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
Stats_Check $?

Print "Installing MongoDB\t"

yum install -y mongodb-org >/tmp/log

Stats_Check $?


Print "Configuring MongoDB\t"

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
Stats_Check $?


Print "Starting MongoDB\t"

systemctl enable mongod
systemctl restart mongod
Stats_Check $?

Print "Downloading mongodb schema"

curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

Stats_Check $?


cd /tmp

Print "Extracting Schema Archive"

unzip -o mongodb.zip >/tmp/log

Stats_Check $?


cd mongodb-main

Print "Loading Schema\t\t"

mongo < catalogue.js >/tmp/log
mongo < users.js  >/tmp/log
Stats_Check $?

exit 0