alias post='curl -s -k -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\"'

MANAGEMENT=api.admin-201841-1202.loki.dev.ciondemand.com

ADMIN_IDP=admin/default-idp-1
export ADMIN_PASSWORD=${ADMIN_PASSWORD:-8iron-hide}

PROVIDER_USER_REGISTRY=api-manager-lur
PROVIDER_IDP=provider/default-idp-2

PROVIDER_USERNAME=steve
PROVIDER_PASSWORD=8iron-hide
PROVIDER_EMAIL=steve@acme.com
PROVIDER_FIRSTNAME=Steve
PROVIDER_LASTNAME=Owner

PORG_NAME=acme
PORG_TITLE=Acme
