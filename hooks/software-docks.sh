#!/bin/bash

cat <<EOT > DOCS.md
## OS Information

$(grep -w FROM Dockerfile | awk '{print tolower($0)}' | sed -r 's/(.*:)(.*)-(.*)$/- \2 \3/')

## Installed Software

$(grep -w "ARG .*_VERSION=\"[0-9]*\.[0-9]*\.[0-9]*\"" Dockerfile | awk '{print tolower($0)}' | sed -r 's/arg(.*)(_version=\")(.*)\"$/-\1 \3/')
EOT
