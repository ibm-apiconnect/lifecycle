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
echo Create the OpenAPI definition from the WSDL
rm calculator100-api.yaml
apic create:api --api_type wsdl --wsdl calculator100.wsdl
mv calculator.yaml calculator100-api.yaml



echo
echo Create the Math Product referencing the Calculator API
rm math100-product.yaml
apic create:product --name "math" --version "1.0.0" --title "Math Product" --apis "calculator100-api.yaml" --filename math100-product.yaml



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
               -F "product=@math100-product.yaml" \
               -F "openapi=@calculator-api.yaml"`
echo ${response} | jq .
export provider_token=`echo ${response} | jq -r '.access_token'`
