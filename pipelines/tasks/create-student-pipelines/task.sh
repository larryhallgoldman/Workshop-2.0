#!/bin/bash

set -e

#pushd Workshops-2.0
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
    PASS=$(echo $i | jq -r '.password')
    fly -t env set-pipeline -p "accounts-service-$USER" -c accounts-service/ci/accounts-service/pipeline.yml \
    -v git-uri=$accounts_git_uri \
    -v git-branch=$accounts_git_branch \
    -v cf-api-uri=$cf_api_uri \
    -v cf-target-url=$cf_target_url \
    -v cf-skip-ssl=true \
    -v cf-username=$USER \
    -v cf-password=$PASS \
    -v cf-org=$USER \
    -v cf-space=$space \
    -v cf-config-server-uri=$cf_config_server_uri \
    -v cf-config-server-label=$cf_config_server_label \
    -v cf-db-service=$cf_db_service \
    -v cf-db-service-plan=$cf_db_service_plan \
    -v cf-db-service-name=$cf_db_service_name \
    --non-interactive

    fly -t env set-pipeline -p "quotes-service-$USER" -c quotes-service/ci/quotes-service/pipeline.yml \
    -v git-uri=$quotes_git_uri \
    -v git-branch=$quotes_git_branch \
    -v cf-api-uri=$cf_api_uri \
    -v cf-target-url=$cf_target_url \
    -v cf-skip-ssl=true \
    -v cf-username=$USER \
    -v cf-password=$PASS \
    -v cf-org=$USER \
    -v cf-space=$space \
    -v cf-config-server-uri=$cf_config_server_uri \
    -v cf-config-server-label=$cf_config_server_label \
    -v cf-db-service=$cf_db_service \
    -v cf-db-service-plan=$cf_db_service_plan \
    -v cf-db-service-name=$cf_db_service_name \
    --non-interactive

    fly -t env set-pipeline -p "user-service-$USER" -c user-service/ci/user-service/pipeline.yml \
    -v git-uri=$user_git_uri \
    -v git-branch=$user_git_branch \
    -v cf-api-uri=$cf_api_uri \
    -v cf-target-url=$cf_target_url \
    -v cf-skip-ssl=true \
    -v cf-username=$USER \
    -v cf-password=$PASS \
    -v cf-org=$USER \
    -v cf-space=$space \
    -v cf-config-server-uri=$cf_config_server_uri \
    -v cf-config-server-label=$cf_config_server_label \
    -v cf-db-service=$cf_db_service \
    -v cf-db-service-plan=$cf_db_service_plan \
    -v cf-db-service-name=$cf_db_service_name \
    --non-interactive

    fly -t env set-pipeline -p "portfolio-service-$USER" -c portfolio-service/ci/portfolio-service/pipeline.yml \
    -v git-uri=$portfolio_git_uri \
    -v git-branch=$portfolio_git_branch \
    -v cf-api-uri=$cf_api_uri \
    -v cf-target-url=$cf_target_url \
    -v cf-skip-ssl=true \
    -v cf-username=$USER \
    -v cf-password=$PASS \
    -v cf-org=$USER \
    -v cf-space=$space \
    -v cf-config-server-uri=$cf_config_server_uri \
    -v cf-config-server-label=$cf_config_server_label \
    -v cf-db-service=$cf_db_service \
    -v cf-db-service-plan=$cf_db_service_plan \
    -v cf-db-service-name=$cf_db_service_name \
    --non-interactive

    fly -t env set-pipeline -p "web-service-$USER" -c web-service/ci/web/pipeline.yml \
    -v git-uri=$web_git_uri \
    -v git-branch=$web_git_branch \
    -v cf-api-uri=$cf_api_uri \
    -v cf-target-url=$cf_target_url \
    -v cf-skip-ssl=true \
    -v cf-username=$USER \
    -v cf-password=$PASS \
    -v cf-org=$USER \
    -v cf-space=$space \
    -v cf-config-server-uri=$cf_config_server_uri \
    -v cf-config-server-label=$cf_config_server_label \
    -v cf-db-service=$cf_db_service \
    -v cf-db-service-plan=$cf_db_service_plan \
    -v cf-db-service-name=$cf_db_service_name \
    --non-interactive

done

#popd
