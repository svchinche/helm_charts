#!/bin/bash

### Undeploying product

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

## Prereq
sh $SCRIPTPATH/mongo/pre-deploy.sh $namespace

## Deployment Scripts
sh $SCRIPTPATH/mongo/deploy.sh $namespace
sh $SCRIPTPATH/config/deploy.sh $namespace
sh $SCRIPTPATH/employee/deploy.sh $namespace
sh $SCRIPTPATH/department/deploy.sh $namespace
sh $SCRIPTPATH/organization/deploy.sh $namespace
sh $SCRIPTPATH/proxy/deploy.sh $namespace

## Post Deployment script
sh $SCRIPTPATH/mongo/import_data_into_mongo.sh
