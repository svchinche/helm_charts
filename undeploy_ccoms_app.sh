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

sh $SCRIPTPATH/proxy/undeploy.sh $namespace
sh $SCRIPTPATH/department/undeploy.sh $namespace
sh $SCRIPTPATH/organization/undeploy.sh $namespace
sh $SCRIPTPATH/employee/undeploy.sh $namespace
sh $SCRIPTPATH/config/undeploy.sh $namespace
sh $SCRIPTPATH/mongo/undeploy.sh $namespace

kubectl delete namespace $namespace