#!/usr/bin/bash

declare app="sonarqube"

aws ec2 describe-images --region=us-east-1 --filters "Name=tag:Name,Values=${app}*" --query 'Images[?CreationDate<=`2023-03-30`][ImageId]' --output test > ami.txt

if [ -s ami.txt ]
then
        for ami in `cat ami.txt`
        do
#                declare rdev="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[RootDeviceName]' --output text)"
#                declare snap="$(aws ec2 describe-images --image-id $ami --query 'Images[*].BlockDeviceMappings[?DeviceName==`/dev/xvda`].Ebs.SnapshotId' --output text)"
                declare snap="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[BlockDeviceMappings[*].Ebs.SnapshotId]' --output text)"
#                echo $rdev
#                echo $snap
                if [ ! -z "$snap" ]
                then
#                       aws ec2 deregister-image --image-id $ami
#                       aws ec2 delete-snapshot --snapshot-id $snap
                       echo $ami
                       echo $snap
                fi
        done
fi