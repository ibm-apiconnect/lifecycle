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



echo Get the Cloud Scoped Provider Organization Invitations
response=`curl -X GET https://${management}/api/cloud/org-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .


echo Get the Cloud Scoped Admin Identity Providers
response=`curl -X GET https://${management}/api/cloud/admin/identity-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Admin Provider Providers
response=`curl -X GET https://${management}/api/cloud/provider/identity-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Topology
response=`curl -X GET https://${management}/api/cloud/topology \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Mail Server Configured
response=`curl -X GET https://${management}/api/cloud/settings/mail-server-configured \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped User Registry Setting
response=`curl -X GET https://${management}/api/cloud/settings/user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Notification Templates
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Settings Role Defaults
response=`curl -X GET https://${management}/api/cloud/settings/role-defaults \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Integrations
response=`curl -X GET https://${management}/api/cloud/integrations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo Get the Cloud Scoped Registrations
response=`curl -X GET https://${management}/api/cloud/registrations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
