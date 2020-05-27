#!/bin/bash

### Undeploying product

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

sh $SCRIPTPATH/proxy/undeploy.sh $application_name
sh $SCRIPTPATH/department/undeploy.sh $application_name
sh $SCRIPTPATH/organization/undeploy.sh $application_name
sh $SCRIPTPATH/employee/undeploy.sh $application_name
sh $SCRIPTPATH/config/undeploy.sh $application_name
sh $SCRIPTPATH/mongo/undeploy.sh $application_name

kubectl delete namespace $application_name