#!/bin/bash

### Undeploying product

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

sh $SCRIPTPATH/mongo/undeploy.sh $application_name
sh $SCRIPTPATH/config/undeploy.sh $application_name
sh $SCRIPTPATH/employee/deploy.sh $application_name
sh $SCRIPTPATH/department/deploy.sh $application_name
sh $SCRIPTPATH/organization/deploy.sh $application_name
sh $SCRIPTPATH/proxy/deploy.sh $application_name

