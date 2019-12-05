#!/bin/bash

# Functions/aliases/base environment variables
. ./.env


# Set the porg to the name of the provider organization to introspect
export porg=acme


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
echo Get the Provider Organization Settings
response=`curl -X GET ${porg_url}/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Notification Templates
response=`curl -X GET ${porg_url}/settings/notification-templates \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Provider Organization Notification Templates Provider
response=`curl -X GET ${porg_url}/settings/notification-templates/provider \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Provider Organization Notification Templates Catalog
response=`curl -X GET ${porg_url}/settings/notification-templates/catalog \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Provider Organization Notification Templates Space
response=`curl -X GET ${porg_url}/settings/notification-templates/space \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Provider Organization Notification Templates Consumer
response=`curl -X GET ${porg_url}/settings/notification-templates/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Provider Organization User Registries
response=`curl -X GET ${porg_url}/user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Member Invitations
response=`curl -X GET ${porg_url}/member-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Associates
response=`curl -X GET ${porg_url}/associates \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Members
response=`curl -X GET ${porg_url}/members \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Roles
response=`curl -X GET ${porg_url}/roles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Gateway Services
response=`curl -X GET ${porg_url}/gateway-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Portal Services
response=`curl -X GET ${porg_url}/portal-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization OAuth Providers
response=`curl -X GET ${porg_url}/oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Billings
response=`curl -X GET ${porg_url}/billings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization TLS Client Profiles
response=`curl -X GET ${porg_url}/tls-client-profiles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Keystores
response=`curl -X GET ${porg_url}/keystores \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Truststores
response=`curl -X GET ${porg_url}/truststores \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Catalogs
response=`curl -X GET ${porg_url}/catalogs \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Catalog Invitations
response=`curl -X GET ${porg_url}/catalog-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Drafts
response=`curl -X GET ${porg_url}/drafts \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Draft Products
response=`curl -X GET ${porg_url}/draft-products \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Provider Organization Draft APIs
response=`curl -X GET ${porg_url}/draft-apis \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
