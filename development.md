# Publishing

```
# Shavon authenticates
curl -X POST 'https://management.com/api/token' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k \
     -d '{ "realm": "provider/default-idp",
           "username": "shavon@acme.com",
           "password": "some-password",
           "client_id": "caa87d9a-8cd7-4686-8b6e-ee2cdc5ee267",
           "client_secret": "3ecff363-7eb3-44be-9e07-6d4386c48b0b",
           "grant_type": "password" }'

# Shavon publishes the climbon100.yaml product containing routes100.yaml API and the trails100.yaml API
# Assumes the alpha provider organization's development catalog is of type production=false
# Hot replaces the existing product/apis
curl -X POST https://management.com/api/catalogs/alpha/development/publish -H 'Content-Type:multipart/form-data' -H 'Accept:application/json' -H 'Authorization:Bearer shavon-token-here' -i -s -k \
     -F "product=@/Users/shavon/climbon100.yaml;type=application/yaml" \
     -F "openapi=@/Users/shavon/routes100.yaml;type=application/yaml" \
     -F "openapi=@/Users/shavon/trails100.yaml;type=application/yaml"
```



# Subscribing

```
# Andre authenticates
curl -X POST 'https://portal.com/consumer-api/token' -H 'X-IBM-Consumer-Context:alpha.development' -H 'Content-Type:application/json' -H 'Accept:application/json' -i -s -k \
     -d '{ "realm": "consumer:alpha:development/development-idp",
           "username": "andre@acme.com",
           "password": "some-password",
           "client_id": "caa87d9a-8cd7-4686-8b6e-ee2cdc5ee267",
           "client_secret": "3ecff363-7eb3-44be-9e07-6d4386c48b0b",
           "grant_type": "password" }'

# Andre creates the application named "climbing-application-name" in his consumer provider organization named "andre-consumer-org-name"
curl -X POST 'https://portal.com/consumer-api/orgs/andre-consumer-org-name/apps' -H 'X-IBM-Consumer-Context:alpha.development' -H 'Content-Type:application/json' -H 'Accept:application/json' -H 'Authorization:Bearer andre-token-here' -i -s -k \
     -d '{ "name": "climbing-application-name",
           "title": "Climbing Application Title" }'

# Andre gets the list of the products in the catalog
# Required to get the product_url

# Andre subscribes to the climbon product's plan named "default"
curl -X POST 'https://portal.com/consumer-api/apps/andre-consumer-org-name/climbing-application-name/subscriptions' -H 'X-IBM-Consumer-Context:alpha.development' -H 'Content-Type:application/json' -H 'Accept:application/json' -H 'Authorization:Bearer andre-token-here' -i -s -k \
     -d '{ "title": "Climbing Product Subscription",
           "product_url": "https://management.com/api/catalogs/463de547-6f31-4c1c-922d-7fc2abfa285b/02fa49ce-71a7-44ae-bc7c-ec1a2a418f72/products/3d1ed3bc-57d4-4f78-a2b3-b9ad2dd39ecf",
           "plan": "default" }'
```
