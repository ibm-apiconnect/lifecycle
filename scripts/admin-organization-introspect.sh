#!/bin/bash

# Functions/aliases/base environment variables
. ./.env



# Define/customize
export management=${management:-some-management-host}
export admin_idp=${admin_idp:-admin/default-idp-1}
export admin_password=${admin_password:-some-password}



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
echo Get the Admin Organization
response=`curl -X GET https://${management}/api/orgs/admin \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Admin Organization Settings
response=`curl -X GET https://${management}/api/orgs/admin/settings \
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
echo Get the Provider Organization Notification Templates Admin
response=`curl -X GET ${porg_url}/settings/notification-templates/admin \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Admin Organization User Registries
response=`curl -X GET https://${management}/api/orgs/admin/user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Admin Organization Member Invitations
response=`curl -X GET https://${management}/api/orgs/admin/member-invitations \
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
echo Get the Admin Organization Availability Zones
response=`curl -X GET https://${management}/api/orgs/admin/availability-zones \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Admin Organization OAuth Providers
response=`curl -X GET https://${management}/api/orgs/admin/oauth-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Admin Organization Mail Servers
response=`curl -X GET https://${management}/api/orgs/admin/mail-servers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Admin Organization TLS Server Profiles
response=`curl -X GET https://${management}/api/orgs/admin/tls-server-profiles \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Admin Organization TLS Client Profiles
response=`curl -X GET https://${management}/api/orgs/admin/tls-client-profiles \
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
