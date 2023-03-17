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
#aws ec2 describe-images --filters "Name=tag:Name,Values=${app}*" --query "Images[?CreationDate<=\`$date\`] | sort_by(@,&CreationDate)[].{id:ImageId,date:CreationDate}" --output text

if[ ! -z "$amis" ]
then
       for ami in ${amis[@]}
       do
               declare snap="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[BlockDeviceMappings[*].Ebs.SnapshotId]' --output text)"
               declare createdate="$(aws ec2 describe-images --image-id $ami --query 'Images[*].[CreationDate]' --output text)"

               if [ ! -z "$snap" ]
               then
                       if [ $dryrun == 'true' ]
                       then
                               echo "Dry-run for AMI:$ami $createdate and Snapshot:$snap - no action taken"
                       else
                               aws ec2 deregister-image --image-id $ami
                               aws ec2 delete-snapshot --snapshot-id $snap
                               echo "$ami and $snap are deregistered/deleted"
                       fi
                fi
        done
fi

echo ;
echo "Done";
echo ;