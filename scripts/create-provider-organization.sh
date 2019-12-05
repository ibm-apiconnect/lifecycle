#!/bin/bash

# Functions/aliases/base environment variables
source ./env.sh



echo Authenticate as the admin user
response=`curl -X POST https://${management}/api/token \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -d "{ \"realm\": \"${admin-idp}\",
                     \"username\": \"admin\",
                     \"password\": \"${admin-password}\",
                     \"client_id\": \"599b7aef-8841-4ee2-88a0-84d49c4d6ff2\",
                     \"client_secret\": \"0ea28423-e73b-47d4-b40e-ddb45c48bb0c\",
                     \"grant_type\": \"password\" }"`
echo ${response} | jq .
export token=`echo ${response} | jq -r '.access_token'`



echo Create the Provider Organization Owner
response=`curl https://${management}/api/user-registries/admin/${provider-user-registry}/users \
               -s -k -H "Content-Type:application/json" -H "Accept:application/json" \
               -H "Authorization: Bearer ${token}" \
               -d "{ \"username\": \"${provider-username}\",
                     \"password\": \"${provider-password}\",
                     \"email\": \"${provider-email}\",
                     \"first_name\": \"${provider-firstname}\",
                     \"last_name\": \"${provider-lastname}\" }"`
echo ${response} | jq .
export user-url=`echo ${response} | jq -r '.url'`



echo Create the Provider Organization
response=`curl https://${management}/api/cloud/orgs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}" \
               -d "{ \"name\": \"${porg-name}\",
                     \"title\": \"${porg-title}\",
                     \"org_type\": \"provider\",
                     \"owner_url\": \"${owner-url}\" }"`
echo ${response} | jq .
export owner-url=`echo ${response} | jq -r '.url'`



echo Get the Provider Organization Owner
response=`curl -X GET ${owner-url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization
response=`curl -X GET ${porg-url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Delete the Provider Organization
response=`curl -X DELETE ${porg-url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Delete the Provider Organization Owner
response=`curl -X DELETE ${owner-url}
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
