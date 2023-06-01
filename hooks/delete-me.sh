#!/bin/bash
set -euo pipefail

for i in $*
do
    if [[ "$i" == *"deleteme"* ]]
    then
        echo "Deleting accidentally commited file"
        
        exit 1
    fi
done
