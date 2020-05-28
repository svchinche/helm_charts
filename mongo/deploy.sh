#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

# include retry function
. $SCRIPTPATH/../common/utilities.sh

## Create deployment
helm install --debug --namespace=$application_name -f $SCRIPTPATH/../common/values.yaml  $SCRIPTPATH/../mongo


## Create deployment
result=$(kubectl get pod -n $application_name | grep mongo | grep -i running)
until [[ $? -eq 0 ]] ;
do
  echo "Retrying -- Waiting for mongo db container to up";
  sleep 10;
  result=`kubectl get pod -n $application_name | grep mongo | grep -i running`
done

result=$(kubectl exec -i -n $application_name  mongo-0 -- mongo < $SCRIPTPATH/create_user.json)

until [[ $? -eq 0 ]] ;
do
  echo "Retrying -- Creating user on mongo db";
  sleep 10;
  result=$(kubectl exec -i -n $application_name  mongo-0 -- mongo < $SCRIPTPATH/create_user.json)
done

