#!/bin/bash

set -v
set -ex

# login and deploy to PCF
CF_ORG="GEFT_"$1"_"$PCF_ORG_SUFFIX
CF_APP="api.sys."$PCF_CC_HOST_PREFIX"."$1".cf.ford.com"
CF_SPACE="GEFT-"$PCF_ENV_NAME
MANIFEST_FILE="manifest-$PCF_ENV_NAME-$1.yml"

cf login -a $CF_APP -o $CF_ORG -s $CF_SPACE -u $CF_CCUSER -p $CF_CCPASSWORD > loginoutput.txt

if cat loginoutput.txt | grep FAILED; then
   echo login failed
   exit 1
fi

echo "Rolling: $2"

if [ "$2" = "rolling" ]
then
  cf push --strategy rolling -t 600 -f "$MANIFEST_FILE"
else
  cf push -t 600 -f "$MANIFEST_FILE"
fi

cf logout
