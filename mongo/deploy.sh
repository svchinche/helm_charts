#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ $# -lt 1 ]
then
  echo "Usage: $0 -n"
  echo "-n <namespace name>"
  #echo "Setting defualt namespace to ccoms"
  namespace=ccoms
fi

# Need to have a colon (:) after each option that has | an argument.
while getopts n: opt
do
  case $opt in
    n) namespace=$OPTARG;;
    *) echo "Option not recognized"
       namespace=ccoms;;
  esac
done
#echo "namespace name is :: $namespace"

# include retry function
. $SCRIPTPATH/../common/utilities.sh

## Create namespace. as namespace creation at run time not supported in helm3
#kubectl create namespace $namespace

## Create deployment
helm install --debug mongo --namespace=$namespace -f $SCRIPTPATH/../common/values.yaml  $SCRIPTPATH/../mongo


## Create deployment
#result=$(kubectl get pod -n $namespace | grep mongo | grep -i running)
#until [[ $? -eq 0 ]] ;
#do
#  echo "Retrying -- Waiting for mongo db container to up";
#  sleep 10;
# result=`kubectl get pod -n $namespace | grep mongo | grep -i running`
#done

#result=$(kubectl exec -i -n $namespace  mongo-0 -- mongo < $SCRIPTPATH/create_user.json)

#until [[ $? -eq 0 ]] ;
#do
#  echo "Retrying -- Creating user on mongo db";
#  sleep 10;
#  result=$(kubectl exec -i -n $namespace  mongo-0 -- mongo < $SCRIPTPATH/create_user.json)
#done

