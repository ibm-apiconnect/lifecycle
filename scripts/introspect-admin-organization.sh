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



echo Get the Cloud Scoped Settings
response=`curl -X GET https://${management}/api/cloud/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Integrations
response=`curl -X GET https://${management}/api/cloud/integrations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Provider Organization Invitations
response=`curl -X GET https://${management}/api/cloud/org-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization
response=`curl -X GET https://${management}/api/orgs/admin \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization Settings
response=`curl -X GET https://${management}/api/orgs/admin/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization TLS Server Profiles
response=`curl -X GET https://${management}/api/orgs/admin/tls-server-profiles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization TLS Client Profiles
response=`curl -X GET https://${management}/api/orgs/admin/tls-client-profiles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization User Registries
response=`curl -X GET https://${management}/api/orgs/admin/user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization OAuth Providers
response=`curl -X GET https://${management}/api/orgs/admin/oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization Availability Zones
response=`curl -X GET https://${management}/api/orgs/admin/availability-zones \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Admin Organization Member Invitations
response=`curl -X GET https://${management}/api/orgs/admin/member-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .