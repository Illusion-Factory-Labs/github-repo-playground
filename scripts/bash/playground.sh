#!/bin/zsh
set -euo pipefail

response="$(gh api repos/iLLusion-Factory-Labs/github-repo-playground/environments/prd-vars/variables)"

if [[ "$(jq -r '(.variables // []) | length' <<< "$response")" -eq 0 ]]; then
    echo "No variables found for environment: prd"
    exit 0
fi

jq -c '(.variables // [])[]' <<< "$response" | while read -r var; do
    name=$(echo "$var" | jq -r '.name')
    value=$(echo "$var" | jq -r '.value')
    echo "Variable Name: $name, Variable Value: $value"
done
