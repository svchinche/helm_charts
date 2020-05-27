#!/bin/sh

# include parse_yaml function
. ../common/yaml_parser.sh

# read yaml file
eval $(parse_yaml ../common/values.yaml "config_")

# access yaml content
username=$config_env_secret_CCOMS_DATABASE_USERNAME
password=$config_env_secret_CCOMS_DATABASE_PASSWORD
servicename=$config_env_secret_CCOMS_DATABASE_SERVICENAME

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
