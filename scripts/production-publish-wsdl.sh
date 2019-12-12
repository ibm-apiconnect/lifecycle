#!/bin/bash

# Source default environment variables
. ./.env



# Overview
# - ...



# Environment variables specific to this script
export management=${management}
export provider_idp=${provider_idp}
export provider_username=${provider_username}
export provider_password=${provider_password}
export porg=${porg}
export catalog_prod=${catalog_prod}



echo
echo Authenticate as the Provider Organization Owner
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
echo Publish
response=`curl -X GET https://${management}/api/spaces/${porg}/${catalog_prod}/${space_travel} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`
