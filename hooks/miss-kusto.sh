#!/usr/bin/env bash
set -uo pipefail

check_miss () {
    if ! cat "$1/kustomization.yaml" | grep -q $2;
    then
        echo "$2 is not referenced in $1/kustomization.yaml"
        missing=true
    fi
}

missing=false

for i in $*
do  
    [[ ! "$i" == *"values"* ]] || { continue; }
    [[ "$i" == *".yaml" ]] || { continue; }
    [[ ! "$i" == *"/kustomization.yaml" ]] || { continue; }

    dir=$(dirname $i)
    dirdir=$(dirname $dir)

    if [[ -a "$dir/kustomization.yaml" ]];
    then
        check_miss $dir $(basename $i)
    elif [[ $dir == *"/patches"* ]];
    then
        check_miss $dirdir $(basename $i)
    fi
done

[[ ! $missing ]] || { exit 1; }