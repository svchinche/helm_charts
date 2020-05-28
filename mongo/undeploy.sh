#!/bin/bash


application_name=$1
[[ $application_name == '' ]] && application_name=ccoms;

helm ls  | grep mongo | awk '{print $1}' | xargs helm del --purge

SHARED_DIR="/u02/pvs"

kubectl patch pv pv-nfs-pv0  -p '{"metadata":{"finalizers": []}}' --type=merge
kubectl patch pv pv-nfs-pv1  -p '{"metadata":{"finalizers": []}}' --type=merge
kubectl patch pv pv-nfs-pv2  -p '{"metadata":{"finalizers": []}}' --type=merge
kubectl patch pv pv-nfs-pv3  -p '{"metadata":{"finalizers": []}}' --type=merge
kubectl patch pv pv-nfs-pv4  -p '{"metadata":{"finalizers": []}}' --type=merge

kubectl delete pv pv-nfs-pv0 pv-nfs-pv1 pv-nfs-pv2 pv-nfs-pv3 pv-nfs-pv4 
rm -rf /u02/pvs

[[ ! -d $SHARED_DIR ]] && mkdir -p /u02/pvs
[[ ! -d $SHARED_DIR/pv0 ]] && ( mkdir -p $SHARED_DIR/{pv0,pv1,pv2,pv3,pv4} && chmod -R 777 $SHARED_DIR/ )



