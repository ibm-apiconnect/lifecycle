#!/bin/bash


# Create some aliases and source environment variables
source ./env.sh

response=`curl -s -k -X POST -H "Content-Type:application/json" -H "Accept:application/json" https://$MANAGEMENT/api/token \
    	       -d "{ \"realm\":\"$ADMIN_IDP\",
	       	     \"username\":\"admin\",
		     \"password\":\"8iron-hide\",
		     \"client_id\":\"599b7aef-8841-4ee2-88a0-84d49c4d6ff2\",
		     \"client_secret\":\"0ea28423-e73b-47d4-b40e-ddb45c48bb0c\",
		     \"grant_type\":\"password\" }"`
echo $response | jq .
export ADMIN_TOKEN=`echo $response | jq -r '.access_token'`
echo $ADMIN_TOKEN

echo Create the Provider Organization Owner
response=`curl -s -k -X POST -H "Content-Type:application/json" -H "Accept:application/json" https://$MANAGEMENT/api/user-registries/admin/$PROVIDER_USER_REGISTRY/users \
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
