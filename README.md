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

*NOTE: These are currently a work in progress*

*Scope Management*:
- [cloud-scope-introspect.sh](./scripts/cloud-scope-introspect.sh): Introspect the cloud scoped resources
- [admin-organization-introspect.sh](./scripts/admin-organization-introspect.sh): Introspect the resources in the admin organization
- [provider-organization-create.sh](./scripts/provider-organization-create.sh): Create a provider owner and organization
- [provider-organization-create-delete.sh](./scripts/provider-organization-create-delete.sh): Create and delete a provider owner and organization
- [provider-organization-introspect.sh](./scripts/provider-organization-introspect.sh): Introspect the resources in a provider organization
- [catalog-introspect.sh](./scripts/catalog-introspect.sh): Introspect a catalog
- provider-organization-member-create.sh: Add users to a provider organization
- consumer-organization-create.sh: Create a consumer organization
- consumer-organization-member-create.sh: Add users to a provider organization
- manage-catalog-properties.sh: Manage catalog properties

*Development API Lifecycle*:
- development-cicd.sh: Create an isolated catalog for testing, publish a product, create a consumer org/app, subscribe, test invocations, and tear down

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
