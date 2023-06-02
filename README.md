# pre-commit-hooks

Helpful hooks when working with kustomize

# Installation
1. Copy `.pre-commit-config.yaml` from this repo
2. `pre-commit uninstall` to remove old config
3. From within the git repo you want to install the hooks in, run `pre-commit install -c <path-to-config>/.pre-commit-config.yaml`
# Explanation of hooks
- id: delete-me
Removes any files with deleteme in the name. Useful if you use the command `kustomize build . > deleteme.yaml` to test kustomize config
- id: miss-kusto
Checks if there are any committed yaml files that exist in a directory with a kustomization.yaml file that are not included in that file.
