#!/bin/bash
./validate_prereqs.sh
./env.sh

userURL=`curl -X POST https://$MANAGEMENT/api/user-registries/admin/$PROVIDER_USER_REGISTRY/users -s -k \
	      -H "Content-Type:application/json" \
     	      -H "Accept:application/json" \
	      -H "Authorization:Bearer $ADMIN_TOKEN" \
	      -d "{ \"username\": \"$PROVIDER_USERNAME\",
              	    \"password\": \"$PROVIDER_PASSWORD\",
                    \"email\": \"$PROVIDER_EMAIL\",
                    \"first_name\": \"$PROVIDER_FIRSTNAME\",
                    \"last_name\": \"$PROVIDER_LASTNAME\" }" | jq '.url' `

echo User url: $userURL
