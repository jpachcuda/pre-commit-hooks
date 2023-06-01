#!/bin/bash
set -euo pipefail

for i in $*
do
    if [[ $i == *"deleteme.yaml" ]]
    then
        echo "Deleting accidentally committed file"
        rm -rf $i
        exit 1
    fi
done
