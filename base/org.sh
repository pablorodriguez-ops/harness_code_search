# Set environment variables.
TOKEN=$HARNESS_API_KEY
ACCOUNT=$HARNESS_ACCOUNT_ID

# List all orgs for a given account.
list() {
    curl -s -X GET \
        'https://app.harness.io/v1/orgs' \
        -H "Harness-Account: $ACCOUNT" \
        -H "x-api-key: $TOKEN"
}

$@