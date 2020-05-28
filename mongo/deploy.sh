#!/bin/bash

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

## Create deployment
helm install --debug --namespace=$application_name -f $SCRIPTPATH/../common/values.yaml  $SCRIPTPATH/../mongo


## Create deployment
result=`kubectl get pod -n $application_name | grep mongo | grep -i running`
until [[ $? -eq 0 ]] ;
do
  echo "Retrying";
  sleep 10;
  result=`kubectl get pod -n $application_name | grep mongo | grep -i running`
done

kubectl exec -i -n $application_name  mongo-0 -- mongo < $SCRIPTPATH/create_user.json

