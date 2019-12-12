#!/bin/bash

# Source default environment variables
. ./.env



# Overview
# - ...



# Environment variables specific to this script
export management=${management}
export provider_idp=${provider_idp}
export provider_username=${provider_username}
export provider_password=${provider_password}
export porg=${porg}
export catalog_prod=${catalog_prod}
export space_travel=${space_travel}



echo
echo Create the Routes API
rm routes100-api.yaml
apic create:api --name "routes" --version "1.0.0" --title "Routes API" --filename routes100-api.yaml



echo
echo Create the Trails API
rm trails100-api.yaml
apic create:api --name "trails" --version "1.0.0" --title "Trails API" --filename trails100-api.yaml



echo
echo Create the Climbon Product referencing the Routes and Trails APIs
rm climbon100-product.yaml
apic create:product --name "climbon" --version "1.0.0" --title "Climbon Product" --apis "routes100-api.yaml trails100-api.yaml" --filename climbon100-product.yaml



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
echo Publish the Product to the Space
response=`curl -X POST ${management}/api/spaces/${porg}/${catalog_space}/${space_travel}/publish \
               -s -k -H "Content-Type: multipart/form-data" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -F "product=@climbon100-product.yaml" \
               -F "openapi=@routes100-api.yaml" \
               -F "openapi=@trails100-api.yaml"`
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Create the Consumer Organization Owner
response=`curl`
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Create the Consumer Organization
response=`curl -X POST XXXXXXXXXXXXXXXX \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"name\": \"${corg}\",
                     \"title\": \"${corg_title\" }"`
echo ${response} | jq .
export consumer_org=`echo ${response} | jq -r '.url'



echo
echo Create the Application
response=`curl -X POST ${consumer_org}/apps \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"name\": \"${app}\",
                     \"title\": \"${app_title\" }"`
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Subscribe the Application to the Product
response=`curl -X POST ${consumer_org}/apps \
               -s -k -H "Content-Type: application/json" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -d "{ \"name\": \"${app}\",
                     \"title\": \"${app_title\" }"`
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Get Routes API URL to invoke
response=`curl -X GET XXXX \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Get Trails API URL to invoke
response=`curl -X GET XXXX \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}"
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`



echo
echo Execute tests using the Subscription Credentials



echo
echo Delete the Catalog
response=`curl -X DELETE XXXX`
