#!/usr/bin/bash
set -x

# ensure we were given two command line arguments
if [[ $# -ne 2 ]]; then
        echo 'usage: vault_cp SOURCE DEST' >&2
        exit 1
fi

declare origin=$1
declare dest=$2
declare list=()
declare idx=0
declare token=0
declare trail_path=()
declare -a stair=()

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
            list[idx]=$path$secret
            idx=$((idx+1))
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

for vault in $vaults; do
        traverse $vault
done

for index in ${!list[@]}; do
        echo "${index}: ${list[$index]}"
done

for trail in ${list[@]}; do
        echo "$trail"
        stair[$token]="$(vault kv get --format json $trail | jq -r '.data.data')"
        trail_path[$token]="$(echo $trail | sed -e "s|$origin|$dest|g")"
        token=$((token+1))
        echo "$token"
done

if [[ "${#stair[@]}" == "${#trail_path[@]}" ]]; then
        for ((i=0; i < "${#trail_path[@]}" ; ++i)); do
                echo -n ${stair[$i]} | vault kv put ${trail_path[$i]} -
                echo "copied secrets to ${trail_path[$i]}"
        done
fi