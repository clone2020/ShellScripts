#!/usr/bin/bash

echo "Enter the below values"
echo -n "app:"
read app
echo -n "region:"
read region
echo -n "date:"
read date
echo -n "dryrun:"
read dryrun


aws ec2 describe-images --region=${region} --filters "Name=tag:Name,Values=${app}*" --query "Images[?CreationDate<=\`$date\`][ImageId]" --output test > ami.txt

if [ -s ami.txt ]
then
        for ami in `cat ami.txt`
        do

                declare snap="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[BlockDeviceMappings[*].Ebs.SnapshotId]' --output text)"

                if [ ! -z "$snap" ]
                then
                        if [ $dryrun == 'true' ]
                        then
                                echo $ami
                                echo $snap
                                echo "This is a dry-run"
                        else
                                aws ec2 deregister-image --image-id $ami
                                aws ec2 delete-snapshot --snapshot-id $snap
                                echo "$ami and $snap are deregistered/deleted"
                        fi
                fi
        done
fi