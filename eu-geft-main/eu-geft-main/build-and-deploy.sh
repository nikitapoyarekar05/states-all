#!/bin/bash

set -v
set -e

# Probably unused. Just merged, probably does not work :)

function deployToCluster() {
  export PCF_CLUSTER_NAME=$1
  echo Pushing to $PCF_CLUSTER_NAME - $PCF_ENV_NAME
  ./jenkins-config-server-setup.sh $PCF_CLUSTER_NAME && ./gradlew cf-push-blue-green
}

./gradlew clean build
deployToCluster "EDC1" && deployToCluster "EDC2"

REACT_APP_SHOW_DEV_TOOLS=${REACT_APP_SHOW_DEV_TOOLS} ./gradlew build

cf login -a "${CF_API_ENDPOINT}" -o "${CF_ORG}" -s "${CF_SPACE}" -u "${CF_USER}" -p "${CF_PASSWORD}"
cf push "${CF_APP}" -m 1G -b java_buildpack_offline -p build/libs/checkout-0.0.1-SNAPSHOT.jar
cf logout
