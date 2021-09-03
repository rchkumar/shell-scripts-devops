#!/bin/bash
read -p "Enter the input : " input

if [ -z $input ]
then
    echo "You have enterneted empty value"

fi

echo "Input value is $input"

if [ $? -eq 0 ]
then
 echo "Sucess"
else
 echo "Failure"
 
fi
