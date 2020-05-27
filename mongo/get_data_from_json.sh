#!/bin/sh

# include parse_yaml function
. ../common/yaml_parser.sh

# read yaml file
eval $(parse_yaml ../common/values.yaml "config_")

# access yaml content
username=$config_env_secret_MONGO_INITDB_ROOT_USERNAME
password=$config_env_secret_MONGO_INITDB_ROOT_PASSWORD
servicename=$config_env_secret_MONGO_INITDB_DATABASE

cat > create_user.json <<EOL
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
