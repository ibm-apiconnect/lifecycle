# Deploying API Connect for development and production

An API development initiative typically involves the creation of APIs that are first brought to life in a development environment, then transitioned to 
a higher environment for QA, and finally published into a production catalog. When planning the infrastructure to support this activity, the question 
arises of how to organize the set of API Connect resources: "How many catalogs?", "How many provider orgs?" and so on.

In an environment where different sets of APIs are developed by different business or application teams, it is typical for these API sets to be created 
and tested independently. In the next stages toward production, APIs from different development teams are aggregated in s shared environment for QA, and 
finally brought together in a single shared production environment (possibly vie an intermediate staging environment). This allows 
independence and autonomy at the development team level, while accommodating the need to test APIs together and against common resources on the way to 
production. A topology that follows this structure looks like this:

<p><a target="_blank" rel="noopener noreferrer" href="/ibm-apiconnect/lifecycle/blob/master/lifecycle-states.png">
  <img src="/ibm-apiconnect/lifecycle/raw/master/clouds-orgs-catalogs.png" alt="Lifecycle States" style="max-width:100%;">
</a></p>

In this picture, each development team has their own provider organization, with a development catalog that allows early-stage 
testing of APIs under development. A shared catalog in a separate provider organization allows for sets of APIs from different 
teams to be exercised together (perhaps by applications that make use of more than one API set). QA and staging catalogs provide 
isolated environments prior to publishing content to the production API catalog.

## Concepts

### Cloud
An API Connect cloud is physically comprised of a cluster of management nodes, an associated cluster of portal nodes, and as many gateway clusters (with associated analytics nodes) as required. 
The management nodes maintain a single logical configuration and control the publishing of content to the portal and gateway nodes. A gateway cluster corresponds with a DataPower domain hosted on one or more DataPower nodes.

An API Connect cloud can host multiple API provider organizations (tenants) and their associated configuration and runtime traffic. A cloud can span data centers.


### Provider organization
An API provider organization is a logical tenant in an API Connect cloud, and provides a scope or context in which catalogs of APIs and products can be defined and managed. An organization's members are users with a set of permissions defined by one or more roles.


### Catalog
An API Connect catalog is a logical collection of deployed APIs, managed by a single API provider organization. A catalog may have an associated developer portal site in which published APIs are visible to consumers. APIs published in a catalog expose endpoints hosted on the associated gateway cluster.

The unit of deployment to a catalog is an API product, which comprises a set of one or more APIs and their associated API plans.

### Spaces
Spaces provide optional finer-grained scopes for administering API products within a catalog. Spaces allow multiple teams to independently manage different sets of API products that are deployed to the same catalog. Members of a space have roles and permissions specific to the space, and are prevented from accessing content belonging to other spaces.

As well as governing API lifecycle operations, spaces allow fine-grained control over management of API subscriptions, approvals and analytics access.

## Guidelines

- Use an API Connect cloud for each environment that is to be physically self-contained. Separate clouds have no shared configuration and are fully isolated at runtime.

- In production, the desired number of developer portals drives the required set of catalogs. APIs in a catalog can be published to separate gateway clusters.

- In development, the structure of the API development process determines the number of API provider organizations. A provider organization is the owning entity for a set of APIs, API products and catalogs, and includes a drafts area for storing API and product source. 

- When multiple teams are developing APIs independently, but their output is to be aggregated into a smaller set of catalogs, then intermediate provider orgs facilitate the gathering of content into a context that allows for shared deployment and testing before production.

- Spaces allow multiple teams to independently manage different sets of APIs in the same catalog and its associated portal, and provide control over publishing to different clusters. Spaces are not visible to consumers accessing the portal.

