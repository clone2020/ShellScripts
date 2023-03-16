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

declare amis="$(aws ec2 describe-images --region=${region} --filters "Name=tag:Name,Values=${app}*" --query "Images[?CreationDate<=\`$date\`][ImageId]" --output text)"
declare ami_last="$(echo "${amis[*]}" | tail -n 1)"

if[ ! -z "$amis" ]
then
       if [ -s ami_snap.txt ]
       then
               rm -rf ami_snap.txt
       fi

       for ami in ${amis[@]}
       do

               declare snap="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[BlockDeviceMappings[*].Ebs.SnapshotId]' --output text)"
               declare createdate="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[CreationDate]' --output text)"
               echo "$ami $createdate" >> ami_snap.txt

               if [ ! -z "$snap" ]
               then
                       if [ $dryrun == 'true' ]
                       then
                               if [ $ami == "${ami_last}" ]
                               then
                                       sort -k 2.4 -k 2 ami_snap.txt
                                       echo "This is a dry-run"
                               fi
                       else
                               aws ec2 deregister-image --image-id $ami
                               aws ec2 delete-snapshot --snapshot-id $snap
                               echo "$ami and $snap are deregistered/deleted"
                       fi
                fi
        done
fi