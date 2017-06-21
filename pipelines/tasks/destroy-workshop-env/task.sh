#!/bin/bash

set -e

pushd Workshops-2.0
#  ./gradlew -PversionNumber=$VERSION clean assemble
cf api $cf_target_url --skip-ssl-validation
# Get admin password after successful install using OpsMgr.
cf login -u $cf_username -p $cf_password -o $cf_org -s $cf_space

echo $users | jq -c '.[]' | while read i; do
        # do stuff with $i
        USER=$(echo $i | jq -r '.user')
        cf delete-space -f development -o $USER
        cf delete-org -f $USER
        cf delete-user -f $USER
    done
popd
