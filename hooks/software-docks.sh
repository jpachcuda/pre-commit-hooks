#!/bin/bash
set -euo pipefail

contents=$(cat <<EOT
# Documentation

Documentation detailing what software is installed on the built image.

## OS Information

$(grep -w FROM Dockerfile | awk '{print tolower($0)}' | sed -r 's/(.*:)(.*)-(.*)$/- \2 \3/')

## Installed Software

$(grep -w "ARG .*_VERSION=\"[0-9]*\.[0-9]*\.[0-9]*\"" Dockerfile | awk '{print tolower($0)}' | sed -r 's/arg(.*)(_version=\")(.*)\"$/-\1 \3/')
EOT
)

generate_docs() {
    echo "$contents" > $1
}

if [ ! -f ./DOCS.md ]; then
    echo "DOCS.md not found. Generating..."
    generate_docs "DOCS.md"
    exit 1
fi

if [ "x$contents" != "x$(cat DOCS.md)" ];then
    echo "Updating DOCS.md"
    generate_docs "DOCS.md"
    exit 1
fi

echo "Docs are up to date"
exit 0
