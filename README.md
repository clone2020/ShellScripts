# ShellScripts
Shell scripts for Cloud and Linux issues.

## To Deregister AMI and Delete Snapshots of AMI's for particular Application, please use the below script.

https://github.com/clone2020/ShellScripts/blob/main/aws_ami_snap_deregister_delete.bash

For using the script, please provide the required values similar to as shown below.

$bash aws_ami_snap_deregister_delete.bash

Example..
```
app:sonarqube
region:us-east-1
date:2023-03-30
dryrun:true

```

Change the values as required.

## To copy secrets in Hashicorp vault from one project to other use the below script.

https://github.com/clone2020/ShellScripts/blob/main/vault_cp.bash

For using the script, please create the empty project in vault and then provide the required values similar to as shown below.

$vault login

$./vault_cp.bash <original_project>/ <destination_project>/
