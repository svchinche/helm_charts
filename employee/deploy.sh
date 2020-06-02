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

## Create deployment
helm install --debug employee --namespace=$namespace -f $SCRIPTPATH/../common/values.yaml  $SCRIPTPATH/../employee

