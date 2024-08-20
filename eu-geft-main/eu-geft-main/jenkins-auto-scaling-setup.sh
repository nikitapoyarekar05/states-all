#!/bin/bash

set -v
set -ex

# Configuring the auto scaling
CF_ORG="GEFT_"$1"_"$PCF_ORG_SUFFIX
CF_APP="api.sys."$PCF_CC_HOST_PREFIX"."$1".cf.ford.com"
CF_SPACE="GEFT-"$PCF_ENV_NAME
CF_APP_NAME="eu-geft-"$PCF_NAME
CF_AUTOSCALE_SERVICE_NAME="geft-"$PCF_ENV_NAME"-autoscaler"
CF_AUTOSCALE_CONFIG_PATH="$WORKSPACE/autoscaling/autoscale-$PCF_NAME.yml"
CF_AUTOSCALER_CLI_BINARY_PATH="$WORKSPACE/autoscaling/autoscaler-for-pcf-cliplugin-linux32-binary-2.0.233"

cf login -a $CF_APP -o $CF_ORG -s $CF_SPACE -u $CF_CCUSER -p $CF_CCPASSWORD

cf bind-service $CF_APP_NAME $CF_AUTOSCALE_SERVICE_NAME
cf install-plugin $CF_AUTOSCALER_CLI_BINARY_PATH -f
cf configure-autoscaling $CF_APP_NAME "$CF_AUTOSCALE_CONFIG_PATH"

cf logout
