#!/bin/bash

# Set environment variables.
TOKEN=$HARNESS_API_KEY
ACCOUNT=$HARNESS_ACCOUNT_ID

# List projects for a given org.
# @ param $1 = Org identifier
list() {
    curl -s -X GET \
    "https://app.harness.io/ng/api/projects?accountIdentifier=${ACCOUNT}&orgIdentifier=${1}" \
    -H "x-api-key: $TOKEN"
}

$@