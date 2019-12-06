#!/bin/bash

# Source default environment variables
source ./.env



# Overview
# - Introspect a space



# Environment variables specific to this script
export management=${management}
export provider_user_registry=${provider_user_registry}
export provider_username=${provider_username}
export provider_password=${provider_password}
export porg=${porg}
export catalog=${catalog}
export space=${space}



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
echo Get the Space
response=`curl -X GET https://${management}/api/spaces/${porg}/${catalog}/${space} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`



echo
echo Get the Space Settings
response=`curl -X GET ${space_url}/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Get the Space Notification Templates
response=`curl -X GET ${space_url}/settings/notification-templates \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Notification Templates Space
response=`curl -X GET ${space_url}/settings/notification-templates/space \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Notification Templates Consumer
response=`curl -X GET ${space_url}/settings/notification-templates/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Role Defaults
response=`curl -X GET ${space_url}/role-defaults \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Role Defaults Consumer
response=`curl -X GET ${space_url}/role-defaults/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo Get the Space Roles
response=`curl -X GET ${space_url}/roles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Member Invitations
response=`curl -X GET ${space_url}/member-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Members
response=`curl -X GET ${space_url}/members \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo
echo Get the Space Tasks
response=`curl -X GET ${space_url}/tasks \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Configured Gateway Services
response=`curl -X GET ${space_url}/configured-gateway-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Get the Space Configured API User Registries
response=`curl -X GET ${space_url}/configured-api-user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Get the Space Configured TLS Client Profiles
response=`curl -X GET ${space_url}/configured-tls-client-profiles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Get the Space Configured Billings
response=`curl -X GET ${space_url}/configured-billings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Get the Space OAuth Providers
response=`curl -X GET ${space_url}/configured-oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Get the Space Analytics Services
response=`curl -X GET ${space_url}/analytics-services \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response} | jq .



echo
echo Get the Space Apps
response=`curl -X GET ${space_url}/apps \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Consumer Org Invitations
response=`curl -X GET ${space_url}/consumer-org-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Consumer Orgs
response=`curl -X GET ${space_url}/consumer-orgs \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space Products
response=`curl -X GET ${space_url}/products \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}



echo
echo Get the Space APIs
response=`curl -X GET ${space_url}/apis \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"`
echo ${response}
