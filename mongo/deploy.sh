#!/bin/bash

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

## Create deployment
helm install --debug --namespace=$application_name -f ../common/values.yaml  ../mongo

sh get_data_from_json.sh

## Create deployment
kubectl get pod -n $application_name | grep -i running
until [[ $? -eq 0 ]] ;
do
  echo "Retrying";
  kubectl get pod -n $application_name | grep -i running
  sleep 10;
done

kubectl exec -i -n $application_name  mongo-0 -- mongo < create_user.json

