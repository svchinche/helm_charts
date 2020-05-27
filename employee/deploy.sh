#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

## Create deployment
helm install --debug --namespace=$application_name -f $SCRIPTPATH/../common/values.yaml  $SCRIPTPATH/../employee

