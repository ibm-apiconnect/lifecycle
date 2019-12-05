#!/bin/bash

# Default environment variables
source ./.env



# Define/customize environment variables
export management=${management:-some-management-host}
export admin_idp=${admin_idp:-admin/default-idp-1}
export admin_password=${admin_password:-some-password}
export provider_user_registry=${provider_user_registry:-api-manager-lur}
export provider_username=jason
export provider_email=jason@acme.com
export provider_password=${provider_password:-some-password}
export porg=acme-production
export catalog=production



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
export token=`echo ${response} | jq -r '.access_token'`



echo
echo Create the Provider Production Organization Owner
response=`curl -X POST https://${management}/api/user-registries/admin/${provider_user_registry}/users \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}" \
               -d "{ \"username\": \"${provider_username}\",
                     \"password\": \"${provider_password}\",
                     \"email\": \"${provider_email}\",
                     \"first_name\": \"Jason\",
                     \"last_name\": \"${provider_lastname}\" }"`
echo ${response} | jq .
export owner_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Provider Production Organization
response=`curl -X POST https://${management}/api/cloud/orgs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}" \
               -d "{ \"name\": \"${porg}\",
                     \"title\": \"${porg_title}\",
                     \"org_type\": \"provider\",
                     \"owner_url\": \"${owner_url}\" }"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`



echo
echo Authenticate as the Production Organization Owner
response=`curl -X POST https://${management}/api/token \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -d "{ \"realm\": \"${provider_idp}\",
                     \"username\": \"jason\",
                     \"password\": \"${provider_password}\",
                     \"client_id\": \"599b7aef-8841-4ee2-88a0-84d49c4d6ff2\",
                     \"client_secret\": \"0ea28423-e73b-47d4-b40e-ddb45c48bb0c\",
                     \"grant_type\": \"password\" }"`
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Delete the Sandbox Catalog
response=`curl -X DELETE /catalogs/${porg_url}/sandbox \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provier_token}"`
echo ${response} | jq .



echo
echo Create the Production Organization Prod Catalog
response=`curl -X POST ${porg_url}/catalogs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"name\": \"prod\",
                     \"title\": \"Production Catalog\" }"`
echo ${response} | jq .
export catalog_url=`echo ${response} | jq -r '.url'`



echo
echo Get the Production Organization Prod Catalog Settings
response=`curl -X GET ${catalog_url}/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Update the Production Organization Prod Catalog Settings
response=`curl -X PUT ${catalog_url}/settings \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"production_mode\": true,
                     \"spaces_enabled\": true }"`
echo ${response} | jq .



echo
echo Delete the Production Organization
response=`curl -X DELETE ${porg_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Delete the Production Organization Owner
response=`curl -X DELETE ${owner_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
