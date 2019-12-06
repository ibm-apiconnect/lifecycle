#!/bin/bash

# Source default environment variables
. ./.env



# Overview
- Create User: ${provider_user_registry}/steve-production
- Create Porg: acme-production
- Create Catalog: acme-production/staging
- Create Space: acme-production/staging/travel
- Create Space: acme-production/staging/finance
- Create Space: acme-production/staging/inventory
- Create Catalog: acme-production/prod
- Create Space: acme-production/prod/travel
- Create Space: acme-production/prod/finance
- Create Space: acme-production/prod/inventory



# Environment variables specific to this script
export management=${management}
export admin_idp=${admin_idp}
export admin_password=${admin_password}
export provider_user_registry=${provider_user_registry}
export provider_username=steve-production
export provider_email=steve-production@acme.com
export provider_firstname=${provider_firstname}
export provider_lastname=${provider_lastname}
export porg=acme-production
export porg_title=${porg_title}
export catalog=${catalog}
export catalog_title=${catalog_title}
export space1=travel
export space1_title=Travel Space
export space2=finance
export space2_title=Finance Space
export space3=inventory
export space3_title=Inventory Space



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
export admin_token=`echo ${response} | jq -r '.access_token'`



echo
echo Create the Provider Organization Owner
response=`curl https://${management}/api/user-registries/admin/${provider_user_registry}/users \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${admin_token}" \
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
               -H "Authorization: Bearer ${admin_token}" \
               -d "{ \"name\": \"${porg}\",
                     \"title\": \"${porg_title}\",
                     \"org_type\": \"provider\",
                     \"owner_url\": \"${owner_url}\" }"`
echo ${response} | jq .
export porg_url=`echo ${response} | jq -r '.url'`


echo
echo Create the Prod Catalog
response=`curl -X POST ${porg_url}/catalogs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${catalog}\",
                     \"title\": \"${catalog_title}\" }"`
echo ${response} | jq .
export catalog_url=`echo ${response} | jq -r '.url'`



echo
echo Update the Prod Catalog Settings
response=`curl -X PUT ${catalog_url}/settings \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"spaces_enabled\": true }"`
echo ${response} | jq .



echo
echo Create the Prod Catalog Travel Space
response=`curl -X POST ${catalog_url}/spaces \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${space1}\",
                     \"title\": \"${space1_title}\" }"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Prod Catalog Finance Space
response=`curl -X POST ${catalog_url}/spaces \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${space2}\",
                     \"title\": \"${space2_title}\" }"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Prod Catalog Inventory Space
response=`curl -X POST ${catalog_url}/spaces \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${space3}\",
                     \"title\": \"${space3_title}\" }"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Staging Catalog
response=`curl -X POST ${porg_url}/catalogs \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${catalog}\",
                     \"title\": \"${catalog_title}\" }"`
echo ${response} | jq .
export catalog_url=`echo ${response} | jq -r '.url'`



echo
echo Update the Staging Catalog Settings
response=`curl -X PUT ${catalog_url}/settings \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"spaces_enabled\": true }"`
echo ${response} | jq .



echo
echo Create the Staging Catalog Travel Space
response=`curl -X POST ${catalog_url}/spaces \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${space1}\",
                     \"title\": \"${space1_title}\" }"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Staging Catalog Finance Space
response=`curl -X POST ${catalog_url}/spaces \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${space2}\",
                     \"title\": \"${space2_title}\" }"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`



echo
echo Create the Staging Catalog Inventory Space
response=`curl -X POST ${catalog_url}/spaces \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${production_token}" \
               -d "{ \"name\": \"${space3}\",
                     \"title\": \"${space3_title}\" }"`
echo ${response} | jq .
export space_url=`echo ${response} | jq -r '.url'`
