#!/bin/bash


application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;


pvs_var=(pv-nfs-pv0 pv-nfs-pv1 pv-nfs-pv2 pv-nfs-pv3 pv-nfs-pv4)

# finalizer value is set to 'protect' which will block the deletion.
# K8s keep this as protected since volume data may be required in rollback case.

for pv in ${pvs_var[@]}
do
   kubectl patch pv $pv -p '{"metadata":{"finalizers": []}}' --type=merge
done

helm ls  | grep mongo | awk '{print $1}' | xargs helm del --purge






