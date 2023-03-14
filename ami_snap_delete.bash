#!/usr/bin/bash

declare app="sonarqube"

aws ec2 describe-images --region=us-east-1 --filters "Name=tag:Name,Value=${app}*" --query 'Images[?CreationDate<=`2023-02-28`][ImageId]' --output text > ami.txt
aws ec2 describe-images --region=us-east-1 --filters "Name=tag:Name,Value=${app}*" --query 'Images[?CreationDate<=`2023-02-28`][BlockDeviceMappings]' --output test |awk '{print $5}'|grep "\S" > snapshot.txt

if grep -FRq "snap-" snapshot.txt
then
        for ami in `cat ami.txt`; do aws ec2 deregister-image --image-id $ami; done
        for snap in `cat snapshot.txt`; do aws ec2 delete-snapshot --snapshot-id $snap; done
        echo "1"
else
        aws ec2 describe-images --region=us-east-1 --filters "Name=tag:Name,Values=bitbucket*" --query 'Images[?CreationDate<=`2023-02-28`][BlockDeviceMappings]' --output text |awk '{print $4}'| grep "\S" > snapshot.txt
        for ami in `cat ami.txt`; do aws ec2 deregister-image --image-id $ami; done
        for snap in `cat snapshot.txt`; do aws ec2 delete-snapshot --snapshot-id $snap; done
        echo "2"
fi        