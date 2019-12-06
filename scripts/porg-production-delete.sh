#!/bin/bash

# Source default environment variables
. ./.env



# Overview
- Delete User: ${provider_user_registry}/steve-production
- Delete Porg: acme-production



# Environment variables specific to this script
export management=${management}
export admin_idp=${admin_idp}
export admin_password=${admin_password}
export porg=acme-production



echo
echo Authenticate as the admin user
response=`curl -X POST https://${management}/api/token \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -d "{ \"realm\": \"${admin_idp}\",
                     \"username\": \"admin\",
                     \"password\": \"${admin_password}\",
                     \"client_id\": \"599b7aef-8841-4ee2-88a0-84d49c4d6ff2\",
                     \"client_secret\": \"0ea28423-e73b-47d4-b40e-ddb45c48bb0c\",
                     \"grant_type\": \"password\" }"`
echo ${response} | jq .
export admin_token=`echo ${response} | jq -r '.access_token'`



echo
echo Get the Provider Organization
response=`curl -X GET https://${management}/api/orgs/${porg} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`
export owner_url=`echo ${response} | jq -r '.owner_url'`



echo
echo Delete the Provider Organization
response=`curl -X DELETE ${porg_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${admin_token}"`
echo ${response} | jq .



echo
echo Delete the Provider Organization Owner
response=`curl -X DELETE ${owner_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${admin_token}"`
echo ${response} | jq .
