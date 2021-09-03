#!/bin/bash

Stats_Check(){
    
    
    if [ $1 -eq 0 ]
    then
    echo -e "\e[32mSUCCESS\e[0m"
    else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
    fi
}


Print() {
    echo -n -e "$1 \t- "
}


if [ $UID -ne 0 ];
then
echo -e "\e[1;33mYou should execute this script as root user\e[0m"
exit 1
fi

  