#!/bin/bash

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

## Create deployment
helm install --debug --namespace=$application_name -f ../common/values.yaml  ../employee

