#!/bin/bash

# Source default environment variables
. ./.env



# Overview
# - Create User: ${provider_user_registry}/steve
# - Create Porg: acme
# - Create Catalog: acme/prod
# - Create Space: acme/prod/travel



# Environment variables specific to this script
export management=${management}
export admin_idp=${admin_idp}
export admin_password=${admin_password}
export provider_user_registry=${provider_user_registry}
export provider_username=${provider_username}
export provider_email=${provider_email}
export provider_firstname=${provider_firstname}
export provider_lastname=${provider_lastname}
export porg=${porg}
export porg_title=${porg_title}
export catalog=${catalog}
export catalog_title=${catalog_title}
export space=${space}
export space_title=${space_title}



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
echo Create the Provider Organization Owner
response=`curl -X POST https://${management}/api/user-registries/admin/${provider_user_registry}/users \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${admin_token}" \
               -d "{ \"username\": \"${provider_username}\",
                     \"password\": \"${provider_password}\",
                     \"email\": \"${provider_email}\",
                     \"first_name\": \"${provider_firstname}\",
                     \"last_name\": \"${provider_lastname}\" }"`
echo ${response} | jq .
export owner_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Provider Organization
response=`curl -X POST https://${management}/api/cloud/orgs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${admin_token}" \
               -d "{ \"name\": \"${porg}\",
                     \"title\": \"${porg_title}\",
                     \"org_type\": \"provider\",
                     \"owner_url\": \"${owner_url}\" }"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`



echo
echo Authenticate as the provider organization owner user
response=`curl -X POST https://${management}/api/token \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -d "{ \"realm\": \"${provider_idp}\",
                     \"username\": \"${provider_username}\",
                     \"password\": \"${provider_password}\",
                     \"client_id\": \"599b7aef-8841-4ee2-88a0-84d49c4d6ff2\",
                     \"client_secret\": \"0ea28423-e73b-47d4-b40e-ddb45c48bb0c\",
                     \"grant_type\": \"password\" }"`
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Create the Prod Catalog
response=`curl -X POST ${porg_url}/catalogs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"name\": \"${catalog}\",
                     \"title\": \"${catalog_title}\" }"`
echo ${response} | jq .
export catalog_url=`echo ${response} | jq -r '.url'`



echo
echo Update the Prod Catalog Settings
response=`curl -X PUT ${catalog_url}/settings \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"spaces_enabled\": true }"`
echo ${response} | jq .



echo
echo Create the Prod Catalog Travel Space
response=`curl -X POST ${catalog_url}/spaces \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"name\": \"${space}\",
                     \"title\": \"${space_title}\" }"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`
