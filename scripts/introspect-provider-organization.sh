#!/bin/bash

# Functions/aliases/base environment variables
source ./env.sh



echo Authenticate as the provider organization owner
response=`curl -X POST https://${management}/api/token \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -d "{ \"realm\": \"${provider_idp}\",
                     \"username\": \"${provider_username}\",
                     \"password\": \"${provider_password}\",
                     \"client_id\": \"599b7aef-8841-4ee2-88a0-84d49c4d6ff2\",
                     \"client_secret\": \"0ea28423-e73b-47d4-b40e-ddb45c48bb0c\",
                     \"grant_type\": \"password\" }"`
echo ${response} | jq .
export token=`echo ${response} | jq -r '.access_token'`



echo Get the Provider Organization
response=`curl -X GET $https://${management}/api/orgs/${porg} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`



echo Get the Provider Organization Settings
response=`curl -X GET ${porg_url}/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Gateway Services
response=`curl -X GET ${porg_url}/gateway-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization TLS Client Profiles
response=`curl -X GET ${porg_url}/tls-client-profiles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization User Registries
response=`curl -X GET ${porg_url}/user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization OAuth Providers
response=`curl -X GET ${porg_url}/oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Catalogs
response=`curl -X GET ${porg_url}/catalogs \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Member Invitations
response=`curl -X GET ${porg_url}/member-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Sandbox Catalog
response=`curl -X GET ${porg_url}/catalogs/sandbox \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Sandbox Catalog Settings
response=`curl -X GET ${porg_url}/catalogs/sandbox/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Sandbox Catalog Properties
response=`curl -X GET ${porg_url}/catalogs/sandbox/properties \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Sandbox Catalog Configured User Registries
response=`curl -X GET ${porg_url}/catalogs/sandbox/configured-catalog-user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Sandbox Catalog Configured Gatway Services
response=`curl -X GET ${porg_url}/catalogs/sandbox/configured-gateway-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Sandbox Catalog Configured API User Registries
response=`curl -X GET ${porg_url}/catalogs/sandbox/configured-api-user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization Sandbox Catalog Configured OAuth Providers
response=`curl -X GET ${porg_url}/catalogs/sandbox/configured-oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
