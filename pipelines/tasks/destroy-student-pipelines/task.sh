#!/bin/bash

set -e

#Get fly command to create pipelines from concourse_password
FLY=/usr/local/bin/fly
echo "Fetching fly...";
curl -SsLk -u "$concourse_username:$concourse_password" "$concourse_url/api/v1/cli?arch=amd64&platform=linux" > $FLY;
chmod +x $FLY;

echo "Logging into Concourse"
fly -t env login -k -c $concourse_url -u $concourse_username -p $concourse_password -n main

echo $users | jq -c '.[]' | while read i; do
    # do stuff with $i
    USER=$(echo $i | jq -r '.user')
    fly -t env destroy-pipeline -p "accounts-service-$USER" --non-interactive
    fly -t env destroy-pipeline -p "quotes-service-$USER" --non-interactive
    fly -t env destroy-pipeline -p "user-service-$USER" --non-interactive
    fly -t env destroy-pipeline -p "portfolio-service-$USER" --non-interactive
    fly -t env destroy-pipeline -p "web-service-$USER" --non-interactive
done
