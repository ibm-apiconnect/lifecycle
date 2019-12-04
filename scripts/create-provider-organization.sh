#!/bin/bash


# Create some aliases and source environment variables
source ./env.sh


echo Create the Provider Organization Owner
response=`post https://$MANAGEMENT/api/user-registries/admin/$PROVIDER_USER_REGISTRY/users \
               -H "Authorization:Bearer $ADMIN_TOKEN" \
               -d "{ \"username\": \"$PROVIDER_USERNAME\",
                  \"password\": \"$PROVIDER_PASSWORD\",
                  \"email\": \"$PROVIDER_EMAIL\",
                  \"first_name\": \"$PROVIDER_FIRSTNAME\",
                  \"last_name\": \"$PROVIDER_LASTNAME\" }"`
echo $response | jq .
userUrl=`echo $response | jq '.url' `


echo Create the Provider Organization
response=`post https://$MANAGEMENT/api/cloud/orgs \
               -H "Authorization:Bearer $ADMIN_TOKEN" \
               -d "{ \"name\": \"$PORG_NAME\",
                  \"title\": \"$PORG_TITLE\",
                  \"org_type\": \"provider\",
                  \"owner_url\": $userUrl }"`
echo $response | jq .
orgUrl=`echo $userResponse | jq '.url' `
