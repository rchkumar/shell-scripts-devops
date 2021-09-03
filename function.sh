#!/bin/bash
# Declare a function
SAMPLE(){
  echo "I am a function"
  
  b=20
  
  echo "The value of a is $a"
}

## Access a function
SAMPLE

a=10

echo "The value of b is $b"
echo "The value of a after function executes is $a"