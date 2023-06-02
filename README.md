# pre-commit-hooks

Helpful hooks when working with kustomize

# Explanation of hooks
- id: delete-me
Removes any files with deleteme in the name. Useful if you use the command `kustomize build . > deleteme.yaml` to test kustomize config
- id: miss-kusto
Checks if there are any committed yaml files that exist in a directory with a kustomization.yaml file that are not included in that file.
