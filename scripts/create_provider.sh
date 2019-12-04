#!/bin/bash
./validate_prereqs.sh
source ./env.sh

echo Create Provider Org owner user

userResponse=`curl -X POST https://$MANAGEMENT/api/user-registries/admin/$PROVIDER_USER_REGISTRY/users -s -k \
	           -H "Content-Type:application/json" \
     	      	   -H "Accept:application/json" \
	      	   -H "Authorization:Bearer $ADMIN_TOKEN" \
	      	   -d "{ \"username\": \"$PROVIDER_USERNAME\",
                         \"password\": \"$PROVIDER_PASSWORD\",
                  	 \"email\": \"$PROVIDER_EMAIL\",
                    	 \"first_name\": \"$PROVIDER_FIRSTNAME\",
                    	 \"last_name\": \"$PROVIDER_LASTNAME\" }"`

echo User creation response:
echo $userResponse | jq .

userURL=`echo $userResponse | jq '.url' `

if [ $userURL = "null" ]
then
    echo "Could not create provider org owner user"
    exit 1
fi


echo Provider Org owner user created with url: $userURL, create Provider Org

orgCreationResponse=`curl -X POST https://$MANAGEMENT/api/cloud/orgs -s -k \
                          -H "Content-Type:application/json" \
     			  -H "Accept:application/json" \
     			  -H "Authorization:Bearer $ADMIN_TOKEN" \
     			  -d "{ \"name\": \"$PORG_NAME\",
           		        \"title\": \"$PORG_TITLE\",
           			\"org_type\": \"provider\",
           			\"owner_url\": $userURL }"`

echo Org creation response:
echo $orgCreationResponse | jq .

orgURL=`echo $userResponse | jq '.url' `

if [ $orgURL = "null" ]
then
    echo "Could not create provider org owner user"
    exit 1
fi

if [ $? -ne 0 ]; then
    echo "Could not create provider org"
    exit 1
fi

orgURL=`echo $orgCreationResponse | jq '.url' `

if [ $userURL = "null" ]
then
    echo "Could not create provider org"
    exit 1
fi

echo Provider org created
