*NOTE: This reposistory is a work in progress.*

This repository contains the following articles and scripts that can
be used for CICD automation tasks:

1. Provider Organization and Catalog Design
2. Design Phase
3. Development Lifecycle
4. [Production Lifecycle](./production-lifecycle.md)
5. [API Products](./api-products.md)
6. Production Lifecycle Governance
7. Application Versioning



## Sample Scripts

*Scope Management*:
- [cloud-introspect.sh](./scripts/cloud-introspect.sh): Introspect the cloud scoped resources
- [admin-introspect.sh](./scripts/admin-introspect.sh): Introspect the resources in the admin organization
- [porg-create-delete.sh](./scripts/porg-create-delete.sh): Create and delete a provider owner and organization
- [porg-create.sh](./scripts/porg-create.sh): Create a provider owner and organization
- [porg-introspect.sh](./scripts/porg-introspect.sh): Introspect the provider organization REST resources
- [catalog-introspect.sh](./scripts/catalog-introspect.sh): Introspect the catalog REST resources
- [space-introspect.sh](./scripts/space-introspect.sh): Introspect the space REST resources
- [porg-delete.sh](./scripts/porg-delete.sh): Delete a provider owner and organization
- [porg-production-create-delete.sh](./scripts/porg-production-create-delete.sh): Create and delete a production provider owner and organization, catalogs, and spaces
- [porg-production-create.sh](./scripts/porg-production-create.sh): Create a production provider owner and organization, catalogs, and spaces

*API Lifecycle*:
- [production-publish.sh](./scripts/publish-publish.sh): Publish a product referencing APIs to a space
- [production-publish-wsdl.sh](./scripts/publish-publish-wsdl.sh): Publish a product referencing an API proxy generated from a WSDL to a space

*Production API Lifecycle*:
- production-replace.sh: Replace an old version of a product with a new version in a production catalog
- production-supersede.sh: Supersede an old version of a product with a new version in a production catalog
- production-migrate-all-subscriptions.sh: Publish a new product version, superseding a prior version, and then migrate all the subscriptions
- production-migrate-subscription.sh: Publish a new product version, superseding a prior version, and migrate a single subscription

*Other*:
- catalog-property-management.sh:
- notification-template-management.sh:
- role-defaults-management.sh:
- catalog-replicate.sh:
