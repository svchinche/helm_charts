#!/bin/bash

### Undeploying product

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

## Prereq
sh $SCRIPTPATH/mongo/pre-deploy.sh $application_name

## Deployment Scripts
sh $SCRIPTPATH/mongo/deploy.sh $application_name
sh $SCRIPTPATH/config/deploy.sh $application_name
sh $SCRIPTPATH/employee/deploy.sh $application_name
sh $SCRIPTPATH/department/deploy.sh $application_name
sh $SCRIPTPATH/organization/deploy.sh $application_name
sh $SCRIPTPATH/proxy/deploy.sh $application_name

## Post Deployment script
sh $SCRIPTPATH/mongo/import_data_into_mongo.sh
