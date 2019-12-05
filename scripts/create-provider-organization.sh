#!/bin/bash

# Functions/aliases/base environment variables
source ./env.sh



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
export token=`echo ${response} | jq -r '.access_token'`



echo Create the Provider Organization Owner
response=`curl https://${management}/api/user-registries/admin/${provider_user_registry}/users \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}" \
               -d "{ \"username\": \"${provider_username}\",
                     \"password\": \"${provider_password}\",
                     \"email\": \"${provider_email}\",
                     \"first_name\": \"${provider_firstname}\",
                     \"last_name\": \"${provider_lastname}\" }"`
echo ${response} | jq .
export user_url=`echo ${response} | jq _r '.url'`



echo Create the Provider Organization
response=`curl https://${management}/api/cloud/orgs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}" \
               -d "{ \"name\": \"${porg_name}\",
                     \"title\": \"${porg_title}\",
                     \"org_type\": \"provider\",
                     \"owner_url\": \"${owner_url}\" }"`
echo ${response} | jq .
export owner_url=`echo ${response} | jq -r '.url'`



echo Get the Provider Organization Owner
response=`curl -X GET ${owner_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Provider Organization
response=`curl -X GET ${porg_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



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



echo Delete the Provider Organization
response=`curl -X DELETE ${porg_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Delete the Provider Organization Owner
response=`curl -X DELETE ${owner_url}
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .