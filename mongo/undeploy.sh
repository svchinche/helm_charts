#!/bin/bash


application_name=$1
SHARED_DIR="/u02/pvs"
pvs_var=(pv-nfs-pv0 pv-nfs-pv1 pv-nfs-pv2 pv-nfs-pv3 pv-nfs-pv4)

[[ $application_name == '' ]] && application_name=ccoms;

## deleting all resources
helm ls  | grep mongo | awk '{print $1}' | xargs helm del --purge

# finalizer value is set to 'protect' which will block the deletion.
# K8s keep this as protected since volume data may be required in rollback case.

for pv in ${pvs_var[@]}
do
   kubectl patch pv $pv -p '{"metadata":{"finalizers": []}}' --type=merge
done


## Cleanup mongo data on nfs persistent volume
[[ -d $SHARED_DIR ]] && rm -rf $SHARED_DIR && mkdir -p $SHARED_DIR
mkdir -p $SHARED_DIR/{pv0,pv1,pv2,pv3,pv4} && chmod -R 777 $SHARED_DIR/ 
