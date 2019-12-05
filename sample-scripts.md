# Sample Scripts

Authors:
- [Shane Claussen](mailto:claussen@us.ibm.com), Distinguished Engineer & Chief Architect, API Connect
- [Sumanto Biswas](mailto:biswas@us.ibm.com), Development Lead, API Connect
- [Pramodh Ramesh](mailto:vr.pramodh@ibm.com), Offering Management Lead
- [Anh Le](a.le@ibm.com), Developer



## Introduction

The following are an ever growing set of sample REST and/or CLI
scripts for some of the more common automation tasks in API Connect.
If there are issues with these scripts, feel free to reach out to the
authors directly.



## Setup

These scripts require *...more later...*



## Scripts

*NOTE: These are currently a work in progress*

*Scope Management*:
- [cloud-scope-introspect.sh](./scripts/cloud-scope-introspect.sh): Introspect the cloud scoped resources
- [admin-organization-introspect.sh](./scripts/admin-organization-introspect.sh): Introspect the resources in the admin organization
- [provider-organization-create.sh](./scripts/provider-organization-create.sh): Create a provider owner and organization
- [provider-organization-create-delete.sh](./scripts/provider-organization-create-delete.sh): Create and delete a provider owner and organization
- [provider-organization-introspect.sh](./scripts/provider-organization-introspect.sh): Introspect the resources in a provider organization

- [provider-organization-member-create.sh](./scripts/provider-organization-member-create.sh): Add users to a provider organization
- [catalog-introspect.sh](./scripts/catalog-introspect.sh): Introspect a catalog
- [consumer-organization-create.sh](./scripts/consumer-organization-create.sh): Create a consumer organization
- [consumer-organization-member-create.sh](./scripts/provider-organization-member-create.sh): Add users to a provider organization
- [manage-catalog-properties.sh](./scripts/manage-catalog-properties.sh): Manage catalog properties

*Development API Lifecycle*:
- [development-cicd.sh](./scripts/development-publish.sh): Create an isolated catalog for testing, publish a product, create a consumer org/app, subscribe, test invocations, and tear down

*Production API Lifecycle*:
- [production-replace.sh](./scripts/production-replace.sh): Replace an old version of a product with a new version in a production catalog
- [production-supersede.sh](./scripts/production-replace.sh): Supersede an old version of a product with a new version in a production catalog
- [production-migrate-all-subscriptions.sh](./scripts/production-migrate-all-subscriptions.sh): Publish a new product version, superseding a prior version, and then migrate all the subscriptions
- [production-migrate-subscription.sh](./scripts/production-migrate-subscription.sh): Publish a new product version, superseding a prior version, and migrate a single subscription

*Other*:
- [catalog-property-management.sh](./scripts/catalog-property-management.sh):
- [notification-template-management.sh](./scripts/notification-template-management.sh):
- [role-defaults-management.sh](./scripts/role-defaults-management.sh):
