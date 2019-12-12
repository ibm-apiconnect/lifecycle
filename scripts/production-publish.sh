#!/bin/bash

# Source default environment variables
. ./.env



# Overview
# - Publish a product that contains two OpenAPI definitions



# Environment variables specific to this script
export management=${management}
export provider_idp=${provider_idp}
export provider_username=steve-production
export provider_password=${provider_password}
export porg=acme-production
export catalog_prod=${catalog_prod}
export space_travel=${space_travel}



echo
echo Create the Routes API
rm -f routes100-api.yaml
# apic create:api --name "routes" --version "1.0.0" --gateway-type "datapower-api-gateway" --title "Routes API" --filename routes100-api.yaml
apic create:api --name "routes" --version "1.0.0" --title "Routes API" --filename routes100-api.yaml



echo
echo Create the Trails API
rm -f trails100-api.yaml
# apic create:api --name "trails" --version "1.0.0" --gateway-type "datapower-api-gateway" --title "Trails API" --filename trails100-api.yaml
apic create:api --name "trails" --version "1.0.0" --title "Trails API" --filename trails100-api.yaml



echo
echo Create the Climbon Product referencing the Routes and Trails APIs
# rm -f climbon100-product.yaml
# apic create:product --name "climbon" --version "1.0.0" --gateway-type "datapower-api-gateway" --title "Climbon Product" --apis "routes100-api.yaml trails100-api.yaml" --filename climbon100-product.yaml
# apic create:product --name "climbon" --version "1.0.0" --title "Climbon Product" --apis "routes100-api.yaml trails100-api.yaml" --filename climbon100-product.yaml
# Once created, the $ref reference to the API files must be replace with name: api-name:api-version (see climbon100-product.yaml)



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
response=`curl -X POST https://${management}/api/spaces/${porg}/${catalog_prod}/${space_travel}/publish \
               -s -k -H "Content-Type: multipart/form-data" -H "Accept: application/json" \
               -H "Authorization: Bearer ${provider_token}" \
               -F "product=@climbon100-product.yaml;type=application/yaml" \
               -F "openapi=@routes100-api.yaml;type=application/yaml" \
               -F "openapi=@trails100-api.yaml;type=application/yaml"`
echo ${response} | jq .
echo ${response} | jq -r '.api_urls'
