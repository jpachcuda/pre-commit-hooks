#!/usr/bin/env bash
set -euo pipefail

check_miss () {
    if ! cat "$1/kustomization.yaml" | grep -q $2;
    then
        echo "$2 is not referenced in $1/kustomization.yaml"
        exit 1;
    fi
}

for i in $*
do
    dir=$(dirname $i)
    dirdir=$(dirname $dir)
    # It must be a yaml that is not a values or kustomization file
    if [[ ! "$i" == *"values"* ]] && [[ "$i" == *".yaml" ]] && [[ ! "$i" == *"/kustomization.yaml" ]];
    then
        if [[ -a "$dir/kustomization.yaml" ]];
        then
            check_miss $dir $(basename $i)
        # check kustomization a dir above if its a patch
        elif [[ $dir == *"/patches"* ]];
        then
            check_miss $dirdir $(basename $i)
        fi
    fi
done
