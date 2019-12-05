#!/bin/bash

# Functions/aliases/base environment variables
source ./env.sh



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
echo Get the Cloud Scope Settings
response=`curl -X GET https://${management}/api/cloud/settings \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Mail Server Configured Setting
response=`curl -X GET https://${management}/api/cloud/settings/mail-server-configured \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope User Registries Setting
response=`curl -X GET https://${management}/api/cloud/settings/user-registries \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Notification Templates
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Cloud Scope Notification Templates Cloud
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates/cloud \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Cloud Scope Notification Templates Admin
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates/admin \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Cloud Scope Notification Templates Provider
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates/provider \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Cloud Scope Notification Templates Catalog
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates/catalog \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Cloud Scope Notification Templates Space
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates/space \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Cloud Scope Notification Templates Consumer
response=`curl -X GET https://${management}/api/cloud/settings/notification-templates/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response}



echo
echo Get the Cloud Scope Settings Role Defaults
response=`curl -X GET https://${management}/api/cloud/settings/role-defaults \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Settings Role Defaults Provider
response=`curl -X GET https://${management}/api/cloud/settings/role-defaults/provider \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Settings Role Defaults Consumer
response=`curl -X GET https://${management}/api/cloud/settings/role-defaults/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Topology
response=`curl -X GET https://${management}/api/cloud/topology \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .


echo
echo Get the Cloud Scope Admin Identity Providers
response=`curl -X GET https://${management}/api/cloud/admin/identity-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Provider Identity Providers
response=`curl -X GET https://${management}/api/cloud/provider/identity-providers \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Integrations
response=`curl -X GET https://${management}/api/cloud/integrations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Integrations Billing
response=`curl -X GET https://${management}/api/cloud/integrations/billing \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Integrations Payment Method
response=`curl -X GET https://${management}/api/cloud/integrations/payment-method \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Integrations User Registry
response=`curl -X GET https://${management}/api/cloud/integrations/user-registry \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Integrations Gateway Service
response=`curl -X GET https://${management}/api/cloud/integrations/gateway-service \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Registrations
response=`curl -X GET https://${management}/api/cloud/registrations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Permissions
response=`curl -X GET https://${management}/api/cloud/permissions \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Permissions Cloud
response=`curl -X GET https://${management}/api/cloud/permissions/cloud \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Permissions Organization
response=`curl -X GET https://${management}/api/cloud/permissions/org \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Permissions Provider
response=`curl -X GET https://${management}/api/cloud/permissions/provider \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Permissions Deployment
response=`curl -X GET https://${management}/api/cloud/permissions/deployment \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Permissions Consumer
response=`curl -X GET https://${management}/api/cloud/permissions/consumer \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Provider Organization Invitations
response=`curl -X GET https://${management}/api/cloud/org-invitations \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Organizations
response=`curl -X GET https://${management}/api/cloud/orgs \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Provider Groups
response=`curl -X GET https://${management}/api/cloud/provider/groups \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Webhooks
response=`curl -X GET https://${management}/api/cloud/webhooks \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .



echo
echo Get the Cloud Scope Primary Events
response=`curl -X GET https://${management}/api/cloud/primary-events \
               -s -k -H "Accept: application/json" \
               -H "Authorization: Bearer ${token}"`
echo ${response} | jq .
