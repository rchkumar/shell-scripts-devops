#!/bin/bash

LID="lt-0ee2e09e618f3b506"
LVER=2
aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER | jq