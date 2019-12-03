```
# Should add instead a step to authenticate Steve (get token)
curl -X POST 'https://localhost:3003/api/token' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k  -d '{ "realm": "provider/default-idp-2", "username": "ibmapic+steve@gmail.com", "password": "7iron-hide", "client_id": "xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy", "client_secret": "xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy", "grant_type": "password" }'

# Get the provider organization
curl -X GET 'https://localhost:3003/api/orgs/alpha' -H 'Accept:application/json' -i -s -k

# Create prodcatalog
curl -X POST 'https://localhost:3003/api/orgs/alpha/catalogs' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k -d '{ "name": "prodcatalog", "owner_url": "https://localhost:3003/api/user-registries/304e8249-d9a6-4193-a30c-e2e087882f07/75b9cd8a-7dbd-4889-b85f-32600b662c86/users/0eac7d89-7baa-4362-abbd-6057a51cf284" }'

# Get the prodcatalog catalog
curl -X GET 'https://localhost:3003/api/catalogs/alpha/prodcatalog' -H 'Accept:application/json' -i -s -k

# Update prodcatalog production_mode = true
curl -X PUT 'https://localhost:3003/api/catalogs/alpha/prodcatalog/settings' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k -d '{ "production_mode":true}'

# Get the draft products (NOTE: We should remove draft references)
curl -X GET https://localhost:3003/api/orgs/prodCatalog/drafts/draft-products -H 'Content-Type:multipart/form-data' -H 'Accept:application/json' -i -s -k

# Publish product from file system to the catalog
curl -X POST https://localhost:3003/api/catalogs/alpha/prodcatalog/publish -H 'Content-Type:multipart/form-data' -H 'Accept:application/json' -i -s -k -F "product=@/Users/anhle/mesh/Velox/apim/test/data/climbon100.yaml;type=application/yaml" -F "openapi=@/Users/anhle/mesh/Velox/apim/test/data/routes100.yaml;type=application/yaml" -F "openapi=@/Users/anhle/mesh/Velox/apim/test/data/trails100.yaml;type=application/yaml"

# Create consumer
curl -X POST 'https://localhost:3003/api/user-registries/alpha/prodcatalog-catalog/users' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k -d '{ "identity_provider": "sandbox-idp", "username": "andrec", "password": "7iron-hide", "email": "ibmapic+andrec-catalog@gmail.com", "first_name": "AndreC", "last_name": "AppDeveloper" }'

# Invite consumer
curl -X POST 'https://localhost:3003/api/catalogs/alpha/prodcatalog/consumer-orgs' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k -d '{ "name": "weather", "title": "Weather", "owner_url": "https://localhost:3003/api/user-registries/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/70622fcb-7b63-4cc6-81d8-09453a91b960/users/71109ef5-a1e0-415f-86cd-f3d20ba46bc9" }'

# AndreC Authenticate
curl -X POST 'https://localhost:3006/consumer-api/token' -H 'X-IBM-Consumer-Context:alpha.prodcatalog' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k  -d '{ "realm": "consumer:ajpha:sandbox/sandbox-idp", "username": "ibmapic+andrec@gmail.com", "password": "7iron-hide", "client_id": "819a8de7-7204-4adb-918f-391ba39d29d0", "client_secret": "8dad5699-acbf-40ab-85c1-48361981bc75", "grant_type": "password" }'

# Create app as consumer
curl -X POST 'https://localhost:3006/consumer-api/orgs/weather/apps' -H 'X-IBM-Consumer-Context:alpha.prodcatalog' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k -H ' -d '{ "name": "rain", "title": "Rain" }'

# Subscribe as consumer
 curl -X POST 'https://localhost:3006/consumer-api/apps/weather/rain/subscriptions' -H 'X-IBM-Consumer-Context:alpha.prodcatalog' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k -H -d '{ "title": "Weather Subscription", "product_url": "https://localhost:3003/api/catalogs/463de547-6f31-4c1c-922d-7fc2abfa285b/02fa49ce-71a7-44ae-bc7c-ec1a2a418f72/products/3d1ed3bc-57d4-4f78-a2b3-b9ad2dd39ecf", "plan": "bronze" }'

 # Publish product V101 from file system to the catalog
 curl -X POST https://localhost:3003/api/catalogs/alpha/prodcatalog/publish -H 'Content-Type:multipart/form-data' -H 'Accept:application/json' -i -s -k -F "product=@/Users/anhle/mesh/Velox/apim/test/data/climbon101.yaml;type=application/yaml" -F "openapi=@/Users/anhle/mesh/Velox/apim/test/data/routes101.yaml;type=application/yaml" -F "openapi=@/Users/anhle/mesh/Velox/apim/test/data/trails101.yaml;type=application/yaml"

# Replace product V100 by product V101
curl -X POST 'https://localhost:3003/api/catalogs/alpha/prodcatalog/products/354a9f17-624e-488e-8f4c-01b135ede43f/replace' -H 'Accept:application/json' -H 'Content-Type:application/json' -i -s -k -d '{ "product_url": "https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/products/be578242-3413-43cd-b2be-ce0c478012e3", "plans":[{ "source": "bronze", "target": "bronze" }]}'

# Delete product V100
curl -X DELETE 'https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/products/be578242-3413-43cd-b2be-ce0c478012e3' -H 'Accept:application/json' -i -s -k

 # Publish product V200 from file system to the catalog
 curl -X POST https://localhost:3003/api/catalogs/alpha/prodcatalog/publish -H 'Content-Type:multipart/form-data' -H 'Accept:application/json' -i -s -k -F "product=@/Users/anhle/mesh/Velox/apim/test/data/climbon200.yaml;type=application/yaml" -F "openapi=@/Users/anhle/mesh/Velox/apim/test/data/routes200.yaml;type=application/yaml" -F "openapi=@/Users/anhle/mesh/Velox/apim/test/data/trails200.yaml;type=application/yaml"

# Product V200 supersede product V101
curl -X POST 'https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/products/8c9812e4-c6e0-4fb0-8bf2-ace458d0a7ac/supersede' -H 'Accept:application/json' -H 'Content-Type:application/json' -i -s -k -d '{ "product_url": "https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/products/354a9f17-624e-488e-8f4c-01b135ede43f", "plans":[{ "source": "bronze", "target": "bronze" }]}'

# Migrate supscription from V101 product to V200
curl -X POST 'https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/products/354a9f17-624e-488e-8f4c-01b135ede43f/execute-migration-target' -H 'Accept:application/json' -H 'Content-Type:application/json' -i -s -k

# Retired product V101
curl -X PATCH 'https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/products/354a9f17-624e-488e-8f4c-01b135ede43f' -H 'Accept:application/json' -H 'Content-Type:application/json' -i -s -k -d '{ "state": "Retired" }'

# Delete product V101
curl -X DELETE 'https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/products/354a9f17-624e-488e-8f4c-01b135ede43f' -H 'Accept:application/json' -i -s -k

# NOTE: Move to production script
curl -X DELETE 'https://localhost:3003/api/catalogs/69eafa40-42f6-4f02-8e05-7b67d4b27ed3/cdb34c74-ce3a-484c-9802-55f4f480b46c/configured-gateway-services/74994424-a4d5-465a-a17d-98bb4a7e11b4' -H 'Accept:application/json' -i -s -k
```
