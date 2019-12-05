#!/bin/bash


# Functions/aliases/base environment variables
. ./.env



# Define/customize
# - username/email/prog are purposefully different then the defaults
#   since this script creates and deletes the provider
#   owner/organization thus the owner/organization are unique so they
#   are not by other scripts
export management=${management:-some-management-host}
export admin_idp=${admin_idp:-admin/default-idp-1}
export admin_password=${admin_password:-some-password}
export provider_user_registry=${provider_user_registry:-api-manager-lur}
export provider_username=steve-dynamic
export provider_email=steve-dynamic@acme.com
export provider_firstname=${provider_firstname:-Steve}
export provider_lastname=${provider_lastname:-Owner}
export porg=acme-dynamic
export porg_title=${porg_title:-Acme Provider Organization}



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
export owner_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Provider Organization
response=`curl https://${management}/api/cloud/orgs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}" \
               -d "{ \"name\": \"${porg}\",
                     \"title\": \"${porg_title}\",
                     \"org_type\": \"provider\",
                     \"owner_url\": \"${owner_url}\" }"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`



echo
echo Delete the Provider Organization
response=`curl -X DELETE ${porg_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Delete the Provider Organization Owner
response=`curl -X DELETE ${owner_url} \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
