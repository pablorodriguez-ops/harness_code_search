# Set environment variables.
TOKEN=$HARNESS_API_KEY
ACCOUNT=$HARNESS_ACCOUNT_ID

endpoint="https://app.harness.io/code/api/v1/repos"

# List repositories for a given org.
# @ param $1 = Org identifier
# @ param $2 = Project identifier
# @ param $3 = Query string (optional)
list() {
    response=$(curl -s -X GET "${endpoint}?accountIdentifier=${ACCOUNT}&orgIdentifier=${1}&projectIdentifier=${2}&query=${3}" -H "x-api-key: $TOKEN")
    if [[ "$response" == "[]" ]]; then
        na=null
    else
        echo "$response"
    fi
}

$@