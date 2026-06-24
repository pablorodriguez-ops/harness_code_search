#!/bin/bash

# Set environment variables.
export HARNESS_API_KEY="${1}" # pat.lkfte_XWQJW9c3IRDssoCQ.6a3c11de258de92cd7b2f9a4.cvMS0lbGPHADXGU5pFCl
export HARNESS_ACCOUNT_ID="${2}" # lkfte_XWQJW9c3IRDssoCQ

# Set query string.
query="${3}"

# Enable debug mode.
debug=false

# Base path to scripts.
base="./base"

# CSV file to output results to.
mkdir -p "search"
csv_file="search/$(echo $query | sed 's/ /_/g').csv"
echo "Org,Project,Identifier,Git_URL" > "$csv_file"


# ______________________________________________________________________________________________________________________________
# Get all orgs.
orgs="$(${base}/org.sh list | jq -r '[.[].org.identifier] | join(",")')"

# Split org identifiers by comma.
IFS=',' read -ra identifiers <<< "$orgs"
for identifier in "${identifiers[@]}"; do
  echo ""
  echo "Scanning - Query: ${query}"
  
  # Get all projects for the org.
  mapfile -t projects < <(${base}/project.sh list ${identifier} | jq -r '.data.content[].project.identifier')

  for prj in "${projects[@]}"; do
    # Get all repos for the project.
    code=$(${base}/code.sh list ${identifier} ${prj} ${query})
    count=0

    # Convert JSON to an array of objects and iterate over each one
    while IFS= read -r repo; do
      if [ ! -z "$repo" ]; then

        code_identifier=$(echo "$repo" | jq -r '.identifier')
        git_url=$(echo "$repo" | jq -r '.git_url')

        if [ ! -z "$code_identifier" ] && [ ! -z "$git_url" ]; then
          count=$((count+1))
          echo "${identifier},${prj},${code_identifier},${git_url}" >> "$csv_file"
        fi
      fi
    done <<< "$(echo "$code" | jq -c '.[]')"

    log_message="${count} repos found | ORG: ${identifier} Project: ${prj}"
    echo $log_message
  done

done