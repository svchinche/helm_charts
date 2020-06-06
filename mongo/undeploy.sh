#!/bin/bash


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


SHARED_DIR="/u02/pvs"
pvs_var=(pv-nfs-pv0 pv-nfs-pv1 pv-nfs-pv2 pv-nfs-pv3 pv-nfs-pv4)


## deleting all resources
helm del -n $namespace mongo

# finalizer value is set to 'protect' which will block the deletion.
# K8s keep this as protected since volume data may be required in rollback case.

for pv in ${pvs_var[@]}
do
  kubectl patch pv $pv -p '{"metadata":{"finalizers": []}}' --type=merge
  kubectl delete pv $pv
done

#kubectl patch pv -l role=mongo -p '{"metadata":{"finalizers": []}}' --type=merge
#kubectl delete pv -l role=mongo

## Cleanup mongo data on nfs persistent volume
[[ -d $SHARED_DIR ]] && rm -rf $SHARED_DIR && mkdir -p $SHARED_DIR
mkdir -p $SHARED_DIR/{pv0,pv1,pv2,pv3,pv4} && chmod -R 777 $SHARED_DIR/ 
