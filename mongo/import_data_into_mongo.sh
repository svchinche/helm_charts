#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

HOST_NAME=`hostname -f`
PROXY_PORT=8111

JSON_FILES_DIR="$SCRIPTPATH/json_files"
EMP_JSONFILE="$JSON_FILES_DIR/emps.json"
DEPT_JSONFILE="$JSON_FILES_DIR/departments.json"
ORG_JSONFILE="$JSON_FILES_DIR/organization.json"
resources=(emp org dept)


for resource in ${resources[@]}
do
    while [[ $(curl -I -s -L http://$HOST_NAME:$PROXY_PORT/$resource/pretty | awk /HTTP/'{print $2}') != 200 ]]
    do 
       echo "Waiting for $resource service to get running"
       sleep 30;
    done
done


curl -X POST -H "Content-Type: application/json" -d @$EMP_JSONFILE http://$HOST_NAME:$PROXY_PORT/emp/api/addemps
curl -X POST -H "Content-Type: application/json" -d @$DEPT_JSONFILE http://$HOST_NAME:$PROXY_PORT/dept/api/adddepts
curl -X POST -H "Content-Type: application/json" -d @$ORG_JSONFILE http://$HOST_NAME:$PROXY_PORT/org/api/addorgs