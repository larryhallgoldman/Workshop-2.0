#!/bin/bash

set -e

pushd Workshops-2.0
#  ./gradlew -PversionNumber=$VERSION clean assemble
cf api $cf_target_url --skip-ssl-validation
# Get admin password after successful install using OpsMgr.
cf login -u $cf_username -p $cf_password -o $cf_org -s $cf_space

cf create-quota workshop -m 20G -s 1000 -a -1 -r 50 -i 4G --allow-paid-service-plans

echo $users | jq -c '.[]' | while read i; do
    # do stuff with $i
    USER=$(echo $i | jq -r '.user')
    PASS=$(echo $i | jq -r '.password')
    cf create-user $USER $PASS
    cf create-org $USER
    cf create-space development -o $USER
    cf set-org-role $USER $USER OrgManager
    cf set-space-role $USER $USER development SpaceDeveloper
    cf set-quota $USER workshop
done
popd
