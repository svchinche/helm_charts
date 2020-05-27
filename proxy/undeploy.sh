#!/bin/bash


application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

 helm ls  | grep proxy | awk '{print $1}' | xargs helm del --purge
