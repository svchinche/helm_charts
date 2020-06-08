#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")


###
SHARED_DIR="/u02/pvs"
DIRS=(pv0,pv1,pv2,pv3,pv4)
NFS_CONF_DIR='/etc/exports'

### Creating shared directories if not present
[[ ! -d $SHARED_DIR ]] && mkdir -p /u02/pvs
[[ ! -d $SHARED_DIR/pv0 ]] && ( mkdir -p $SHARED_DIR/{pv0,pv1,pv2,pv3,pv4} && chmod -R 777 $SHARED_DIR/ )


### Add entry in etc export file and restart if entry added
if [ -s $NFS_CONF_DIR  ] 
then
  grep 'pvs' $NFS_CONF_DIR >/dev/null || ( sed -i '$ a\/u02/pvs *(rw,sync,no_root_squash,nohide)' $NFS_CONF_DIR && ( systemctl restart nfs && exportfs ) )
else
  echo "/u02/pvs *(rw,sync,no_root_squash,nohide)" >> $NFS_CONF_DIR && ( systemctl restart nfs && exportfs )
fi

###replace hostip and exteripaddressin in k8s manifest file

host_name=$(hostname -f)
externalIPaddress=$(hostname -I | awk '{print $1}')
file_name="$SCRIPTPATH/../common/values.yaml"
sed -i "s/server:.*/server: $host_name/g" $file_name
sed -i "s/^externalIPaddress:.*/externalIPaddress: ${externalIPaddress}/g" $file_name
sed -i "s/networkResource: hostPath/networkResource: nfs/g" $file_name

### Get data from yaml and update it create_user.json

sh $SCRIPTPATH/get_data_from_json.sh
