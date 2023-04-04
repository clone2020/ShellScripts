#!/usr/bin/bash
#set -x

# ensure we were given two command line arguments
if [[ $# -ne 2 ]]; then
        echo 'usage: vault_cp SOURCE DEST' >&2
        exit 1
fi

declare origin=$1
declare dest=$2
declare list
declare trail_path
declare stair

function traverse {
    local -r path="$1"

    result=$(vault kv list --format=yaml $path | awk '{print $2}' 2>&1)

    status=$?
    if [ ! $status -eq 0 ];
    then
        if [[ $result =~ "permission denied" ]]; then
            return
        fi
        >&2 echo "$result"
    fi

    for secret in ${result[@]}; do
        if [[ "$secret" == */ ]]; then
            traverse "$path$secret"
        else
            echo "$path$secret"
        fi
    done
}

# Iterate on all kv engines or start from the path provided by the user
if [[ "$1" ]]; then
    # Make sure the path always end with '/'
    vaults=("${1%"/"}/")
else
    vaults=$(vault secrets list | awk '$2 == "kv"' | awk '{print $1}')
fi

list=$(traverse $vaults)

for trail in ${list}; do
#        keys[$token]="$(vault kv get --format json $trail | jq -r '.data.data | to_entries[].key')"
#        values[$token]="$(vault kv get --format json $trail | jq -r '.data.data | to_entries | [] |.value')"
        stair="$(vault kv get --format json $trail | jq -r '.data.data')"
        trail_path="$(echo $trail | sed -e "s|$origin|$dest|g")"
        echo -n ${stair} | vault kv put ${trail_path} -
        echo "copied secrets to ${trail_path}"
done

echo ;
echo "Done";
echo ;