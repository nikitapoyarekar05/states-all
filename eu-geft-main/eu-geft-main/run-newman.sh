#!/bin/bash

set -e

POSTMAN_ENV_NAME=$1 # Examples: Localhost, DEV, QA, QA_APIC, ... see ./postman/environment files.
NO_PROXY=".cf.ford.com, .authagent.ford.com" # Only PCF calls and AuthAgent calls should skip the proxy, we are not able to retrieve an FMA token with the default no_proxy setting.
no_proxy=".cf.ford.com, .authagent.ford.com"
echo "Running Postman collection: ial-test-collection for environment: $POSTMAN_ENV_NAME"
newman run postman/finapp-test-collection.postman_collection.json -e postman/enviroment/$POSTMAN_ENV_NAME.postman_environment.json
