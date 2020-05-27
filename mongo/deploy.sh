#!/bin/bash

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

## Create deployment
helm install --debug --namespace=$application_name -f ../common/values.yaml  ../mongo

until $(kubectl get pod -n ccoms | grep running) ; 
do 
  echo "Retrying"; 
  sleep 10; 
done

kubectl exec -i -n $application_name  mongodb-0 -- mongo < create_user.json

