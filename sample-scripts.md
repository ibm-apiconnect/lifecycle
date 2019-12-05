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

- [introspect-cloud-scope.sh](./scripts/introspect-cloud-scope.sh): Introspect the cloud scoped resources
- [introspect-admin-organization.sh](./scripts/introspect-admin-organization.sh): Introspect the resources in the admin organization
- [create-provider-organization.sh](./scripts/create-provider-organization.sh): Creates a provider organization owner and a provider organization
- [provision-organization-members.sh](./scripts/provision-organization-members.sh): Creates a provider organization owner and a provider organization
- [manage-catalog-properties.sh](./scripts/manage-catalog-properties.sh): Manage catalog properties

- [catalog-settings.sh](./scripts/catalog-settings.sh): Sets the catalog setting *production* property to *true*
- [cicd.sh](./scripts/cicd.sh): Create an isolated catalog for testing, publish a product, create a consumer org/app, subscribe, test invocations, and tear down
- [replace.sh](./scripts/replace.sh): Replace an old version of a product with a new version in a production catalog
- [supersede.sh](./scripts/replace.sh): Supersede an old version of a product with a new version in a production catalog
- [migrate-all-subscriptions.sh](./scripts/migrate-all-subscriptions.sh): Publish a new product version, superseding a prior version, and then migrate all the subscriptions
- [migrate-subscription.sh](./scripts/migrate-subscription.sh): Publish a new product version, superseding a prior version, and migrate a single subscription
