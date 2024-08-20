#!/bin/bash

set -v
set -ex

# create config server instance in PCF using private key
# that pairs with public key that is configured in GitHub
CF_ORG="GEFT_"$1"_"$PCF_ORG_SUFFIX
CF_APP="api.sys."$PCF_CC_HOST_PREFIX"."$1".cf.ford.com"
CF_SPACE="GEFT-"$PCF_ENV_NAME
CF_SERVICE="eu-geft-"$PCF_ENV_NAME"-config-server"

cf login -a $CF_APP -o $CF_ORG -s $CF_SPACE -u $CF_CCUSER -p $CF_CCPASSWORD

if cf service $CF_SERVICE > /dev/null ;
then
  echo $CF_SERVICE" already exists."
else
PRIVATE_KEY=$(awk '{printf "%s\\n", $0}' "$PRIVATE_KEY_FILE")
cf create-service p.config-server standard $CF_SERVICE -c "$(cat <<EOF
{
   "git": {
       "uri": "git@github.ford.com:global-ecommerce-finance-tech/eu-geft-config.git",
       "privateKey": "$PRIVATE_KEY",
       "label": "main"
   }
}
EOF
)"
fi

cf logout