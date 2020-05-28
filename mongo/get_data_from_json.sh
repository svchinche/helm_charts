#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

# include parse_yaml function
. $SCRIPTPATH/../common/utilities.sh

# read yaml file
eval $(parse_yaml $SCRIPTPATH/../common/values.yaml "config_")

# access yaml content
username=$config_env_secret_MONGO_INITDB_ROOT_USERNAME
password=$config_env_secret_MONGO_INITDB_ROOT_PASSWORD
servicename=$config_env_secret_MONGO_INITDB_DATABASE

cat > $SCRIPTPATH/create_user.json <<EOL
use $servicename;
db.createUser({
    user: "$username",
    pwd: "$password",
    roles: [{
        role: "readWrite",
        db: "$servicename"
    }]
});
EOL
