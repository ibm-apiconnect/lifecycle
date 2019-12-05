#!/bin/bash

# Functions/aliases/base environment variables
source ./.env



# Define the catalog to introspect, catalog by default
export porg=${prog:-acme}
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
echo Get the Provider Organization
response=`curl -X GET $https://${management}/api/orgs/${porg} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`



echo
echo Get the Catalog
response=`curl -X GET ${porg_url}/catalogs/${catalog} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Settings
response=`curl -X GET ${porg_url}/catalogs/${catalog}/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Properties
response=`curl -X GET ${porg_url}/catalogs/${catalog}/properties \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured User Registries
response=`curl -X GET ${porg_url}/catalogs/${catalog}/configured-catalog-user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured Gatway Services
response=`curl -X GET ${porg_url}/catalogs/${catalog}/configured-gateway-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured API User Registries
response=`curl -X GET ${porg_url}/catalogs/${catalog}/configured-api-user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Catalog Configured OAuth Providers
response=`curl -X GET ${porg_url}/catalogs/${catalog}/configured-oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
