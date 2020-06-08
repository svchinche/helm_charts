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


### Undeploying product

sh $SCRIPTPATH/proxy/undeploy.sh -n $namespace
sh $SCRIPTPATH/department/undeploy.sh -n $namespace
sh $SCRIPTPATH/organization/undeploy.sh -n $namespace
sh $SCRIPTPATH/employee/undeploy.sh -n $namespace
sh $SCRIPTPATH/config/undeploy.sh -n $namespace

## deleting namespace
#kubectl delete namespace $namespace

## deleting statefull set object
sh $SCRIPTPATH/mongo/undeploy.sh -n $namespace

