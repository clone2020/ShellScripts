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

declare amis="$(aws ec2 describe-images --region=${region} --filters "Name=tag:Name,Values=${app}*" --query "Images[?CreationDate<=\`$date\`] | sort_by(@,&CreationDate)[].{id:ImageId}" --output text
declare ami_last="$(echo "${amis[*]}" | tail -n 1)"

if[ ! -z "$amis" ]
then

       for ami in ${amis[@]}
       do

               declare snap="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[BlockDeviceMappings[*].Ebs.SnapshotId]' --output text)"

               if [ ! -z "$snap" ]
               then
                       if [ $dryrun == 'true' ]
                       then
                               if [ $ami == "${ami_last}" ]
                               then
                                       aws ec2 describe-images --filters "Name=tag:Name,Values=${app}*" --query "Images[?CreationDate<=\`$date\`] | sort_by(@,&CreationDate)[].{id:ImageId,date:CreationDate}" --output text
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