#!/bin/bash

# Functions/aliases/base environment variables
source ./.env



# Define/customize
export management=${management:-some-management-host}
export provider_idp=provider/default-idp-2
export provider_username=${provider_username:-steve}
export provider_password=${provider_password:-some-password}
export porg=${porg:-acme}
export catalog=${catalog:-sandbox}



echo
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



echo
echo Get the Catalog
response=`curl -X GET https://${management}/api/catalogs/${porg}/${catalog} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
export catalog_url=`echo ${response} | jq -r '.url'`



echo
echo Get the Catalog Settings
response=`curl -X GET ${catalog_url}/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Notification Templates
response=`curl -X GET ${catalog_url}/settings/notification-templates \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Catalog Notification Templates Catalog
response=`curl -X GET ${catalog_url}/settings/notification-templates/catalog \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Catalog Notification Templates Space
response=`curl -X GET ${catalog_url}/settings/notification-templates/space \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Catalog Notification Templates Consumer
response=`curl -X GET ${catalog_url}/settings/notification-templates/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Catalog Roles
response=`curl -X GET ${catalog_url}/roles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Member Invitations
response=`curl -X GET ${catalog_url}/member-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Members
response=`curl -X GET ${catalog_url}/members \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Tasks
response=`curl -X GET ${catalog_url}/tasks \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Role Defaults
response=`curl -X GET ${catalog_url}/role-defaults \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Role Defaults Consumer
response=`curl -X GET ${catalog_url}/role-defaults/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Properties
response=`curl -X GET ${catalog_url}/properties \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured Gateway Services
response=`curl -X GET ${catalog_url}/configured-gateway-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured User Registries
response=`curl -X GET ${catalog_url}/configured-catalog-user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured API User Registries
response=`curl -X GET ${catalog_url}/configured-api-user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured TLS Client Profiles
response=`curl -X GET ${catalog_url}/configured-tls-client-profiles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured Billings
response=`curl -X GET ${catalog_url}/configured-billings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured OAuth Providers
response=`curl -X GET ${catalog_url}/configured-oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Analytics Services
response=`curl -X GET ${catalog_url}/analytics-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Space Invitations
response=`curl -X GET ${catalog_url}/space-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Spaces
response=`curl -X GET ${catalog_url}/spaces \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Apps
response=`curl -X GET ${catalog_url}/apps \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Consumer Organization Invitations
response=`curl -X GET ${catalog_url}/consumer-org-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Consumer Organizations
response=`curl -X GET ${catalog_url}/consumer-orgs \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Consumer Groups
response=`curl -X GET ${catalog_url}/consumer-groups \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Products
response=`curl -X GET ${catalog_url}/products \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog APIs
response=`curl -X GET ${catalog_url}/apis \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Webhooks
response=`curl -X GET ${catalog_url}/webhooks \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Primary Events
response=`curl -X GET ${catalog_url}/primary-events \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
