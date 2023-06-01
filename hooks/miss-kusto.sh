#!/usr/bin/env bash
set -euo pipefail

for i in $*
do
    # It must be a yaml that is not a values or kustomization file
    if [[ ! "$i" == *"values"* ]] && [[ "$i" == *".yaml" ]] && [[ ! "$i" == *"/kustomization.yaml" ]] && [[ -a "$(dirname $i)/kustomization.yaml" ]]
    then
        if ! cat "$(dirname $i)/kustomization.yaml" | grep -q $(basename $i);
        then
            echo "$(basename $i) is not referenced in $(dirname $i)/kustomization.yaml"
            exit 1;
        fi
    fi
done
