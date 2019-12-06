# Production Lifecycle

Authors:
- [Shane Claussen](mailto:claussen@us.ibm.com), Distinguished Engineer & Chief Architect, API Connect
- [Sumanto Biswas](mailto:biswas@us.ibm.com), Development Lead, API Connect



## Introduction

APIs that are ready to be published into production have a much
broader set of considerations than APIs under development.  The key
difference is that these APIs are likely updates to existing APIs that
are already in production.  Thus, the new version of the API needs to
be published without disrupting the existing consumer applications
subscribed to and invoking the prior version(s).  In addition,
strategies for migrating consumer application subscriptions between
product versions will need to be considered.



## Catalog Configuration

APIs being published into production are typically phased through
atleast two catalogs, sometimes more.  In this article we will assume
two catalogs, one named **staging** and another named **production**.
Those catalogs may be part of the same API provider organization, two
different provider organizations in the same API Connect instance, or
two different provider organizations in two physically disparate
instances.  The instance, provider organization, and catalog
cardinaity is dependent on corporate organization and compliance
criteria that are outside the scope of this article.

API Connect supports a boolean catalog configuration property named
`production-mode` that has a critical impact on the behavior of the
catalog.  **For staging and production catalogs we recommend setting
this property `true`.** The `true` value results in behavior that
requires new API products being published to the catalog to have a
unique name and/or version that doesn't conflict with existing API
products that already exist in the catalog.

For example, a production typed catalog can support:

```
1. Publish Climbon v100 product
2. Publish Hiking v100 product
3. Publish Climbon v200 product
```

The example above would result in the co-publishing of two versions of
the Climbon product and a single version of the Hiking product in the
catalog.

However, the following is not supported in a production typed catalog:

```
1. Publish Climbon v100 product
2. Publish Hiking v100 product
3. Publish Climbon v100 product
```

Step 3 would fail for a production typed catalog.  Even though the
product has the same name and version, there is no guarantee that its
contents are the same.  Publishing a different set of contents would
thus likely result in a disruption for the existing consumers of the
Climbon v100 product.  In summary, production typed catalogs provide
some safety constraints requiring explicit governance and control in
production to minimize disrupting existing API consumers.



## Packaging APIs into API Products

In order for APIs to be published to production they must be packaged
in API Products (referred to here as products).  Products contain one
or more plans.  API consumers subscribe to a product's plan enabling
them to invoke any API packaged in the API product that the plan
supports.  APIs should be grouped into products dependent on the
intended consumer consumption model for the APIs.  Plans can be used
to differentiate rate limits, provide access to a subset of the APIs
in a product, or a subset of the operations provided by an API.

Some common examples:

- In the simplest form, a product may have a single plan with an
  unlimited rate limit that references a single API.

- A product may packagine multiple APIs under a single plan.

- A product may packagine multiple APIs under various plans that
  are differentiated by rate limits.

- A product may package multiple APIs and support multiple plans.  The
  plans may provide progressive disclosure to the APIs and/or API
  operations and vary invocation rate limits.

The relationship between an API product and the API is by reference so
the term packaging really means "referencing an API".  To clarify, an
API may be packaged into multiple products (or referenced by multiple
products).  For example, the following pseudo-code demonstrates two
products that reference multiple APIs, one of which is common:

```
Create Tourism v100 product and reference Routes v100 API and Trails v100 API
Create Climbon v100 product and reference Routes v100 API and Climbing Destinations v100 API
Publish Tourism v100 product
Publish Climbon v100 product
```

The result of the above is a catalog containing:
- Tourism v100 product
- Climbon v100 product
- Routes v100 API
- Trails v100 API
- Climbing Destinations v100 API


Thus, the result is there's only one copy of the Routes v100 API in
the catalog, and it can be invoked by consumers who subscribe to
either the Tourism or the Climbon product.

See the [article on API products](./api-products.md) for more detailed
information.



## API Product Deployment

In API Connect, a runtime stack is represented by the catalog
construct.  In order to socialize and/or enforce APIs the product that
references the APIs must be deployed to a catalog.  API products can
either be deployed to a catalog from the online API Manager drafts
location or directly from the file system.

For most production use case cases, we recommend keeping the API
product and OpenAPI definitions in a first class source code control
management system (eg git).  This enables the artifacts to be under a
first class version control with fully support for merging, branch
management, et al, and supports first class integration with CICD
pipelines to support deploying and testing the artifacts.

The API Connect CLIs and REST operations support either *staging* or
*publishing* the product to the catalog.  The *publish* operation
performs staging and publishing as a single macro operation (see the
product lifecycle state machine below).  For production catalog use
cases, particularly those leveraging API Connect's governance
capabilities, we recommend performing the staging and publishing steps
independently.



## Product Lifecycle and Co-Publishing

API products transition through a set of states when they are deployed
to a catalog that are important to understand.  Here is a summary of
the states:

- **Pre-Staged**: If staging requires human task approvals, staged a
  product transitions into the pre-staged state.  Once the task is
  approved, Pre-Stated products transition to Staged.

- **Staged**: Staging a product to a catalog will result in the product
  being in the Staged state.  Staged products are not yet "published",
  meaning, they are not yet subscribeable, not visible in the
  developer portal, nor are they enforced by the gateway.  The staged
  state is essentially represents the "green room" for products; a
  holding state prior to publishing.  The typical transition from the
  Staged state is to the Published state.

- **Published**: Published products are subscribeable, visible in the
  developer portal, and enforced by the gateway.  Published products
  can be transitioned to Deprecated or Retired.

- **Deprecated**: Deprecated products are very similar to Published
  products, however, they are NOT subscribeable.  Deprecated products
  do continue to be enforced by the gateway supporting existing
  consumer application invocations of the referenced APIs.  Deprecated
  products can be returned to the Published state or to the Retired
  state.

- **Retired**: Retired products are no longer subscribeable, visible in
  the developer portal, or enforced by the gateway.  Retired products
  can be re-staged, transitioned to the Archived state, or they can be
  removed altogether from the catalog.

- **Archived**: Archived products are a form of retired products that
  are not directly visible by default in the API Manager user
  experience.  They can be removed from the catalog or transitioned
  back to the Retired state.

It is helpful to understand the product lifecycle particularly as it
relates to different versions of the same product published to the
production catalog.  For example, the following is a pretty typical
scenario when publishing subsequent versions of the same product over
extended periods of time (eg weeks/months/years):

```
T1. Stage/Publish Climbon v100
T2. Stage/Publish Climbon v101 and Deprecate Climbon v100
T3. Stage/Publish Climbon v200
T4. Deprecate Climbon v101 and Climbon v200
T5. Retire/Remove Climbon v101 and Climbon v200
```

At time 2, there may be many subscribers for Climbon v100 that can
continue to invoke its APIs but new subscribers will subscribe to
Climbon v101 and begin invoking its APIs.

At time 3, a new version of the Climbon product is co-published with
the two initial versions.

At time 4, all three versions of the products are now deprecated, so
they remain invokeable, but consumers can no longer subscribe.

And finally at time 5, the APIs are retired and removed from the
catalog.

![Lifecycle States](./lifecycle-states.png)



## API Lifecycle

The APIs referenced by products that have been published to catalogs
also have the following lifecycle states:

- **Staged**: The state of an API whose product is in the Pre-Staged
  or Staged state.

- **Online**: The state an API transitions to when the product
  referencing it is published.  In this state, any consumer that has a
  subscription to the product referencing the API can now invoke the
  API.  Online APIs can be transitioned to the Offline state.  They
  are also automatically transitioned to the Retired state when the
  last product referencing the API is retired.

- **Offline**: In this state the API is no longer invokeable by the
  gateway although its product remains in the Published or
  Deprecreated state.  Offlien APIs can be transitioned back to the
  Online state.  They are also automatically transitioned to the
  Retired state when the last product referencing the API is retired.

- **Retired**: The state of an API referenced by a product that's been
  retired or archived.  Note that retiring a product removes its
  subscriptions since it's no longer invokeable.  If a retired product
  is re-staged and published again, it will start the lifecycle over
  without subscriptions.

The API state can be modified when the product that references the API
is in the published or deprecated state.  At that point, the API can
be toggled between the Online and Offline states.  This scenario is
useful when the API needs to be taken offline temporarily without
impacting the other APIs referenced by the product.

In a scenario where an API is referenced by multiple products, taking
it Offline impacts all of the subscribers of all the products
referencing the API.



## Product Lifecycle Scenarios

The ability to co-publish multiple versions of a product surfaces the
issues of migrating subscriptions between multiple versions.
Migration scenarios range from relatively simple to very complex.  It
is important for API provider organizations to clearly define what
level of freedom of definition they intend to support.



### **Replace**

In this scenario the API provider team discovers spelling errors in
the descriptions of the API operations that have already been
published for which there are already many consumers.  The provider
team's goal is to fix the problem, publish the new version, and then
migrate all tsubscriptions from old product/API to the new version
without any disruption.  We term this scheme a *hot replace* scenario
that uses a *provider side migration* technique.

```
T1. Publish Climbon v100 product with Gold plan and Routes v100 API
T2. Version Routes v101 fixing the spelling issues
T3. Version Climbon v101 to reference Routes v101
T4. Publish Climbon v101 and Deprecate Climbon v100
T5. Migrate subscriptions from Climbon V100 to Climbon V101
T6. Retire Climbon v100
```

Although several CLI or REST operations can be orchestrated together
to support the above scenario API Connect provides a single macro
CLI/operation named **replace** that supports all of the above
lifecycle operations from T4 to T6 in a single step.

For example:
```
T1. Publish Climbon v100 product with Gold plan and Routes v100 API
T2. Stage Climbon v101 product with Gold plan and Routes v101 API
T3. Replace Climbon v100 with Climbon v101
```

The replace macro operation can only be used when the subsequent
product contains a proper superset of the plans and APIs from the
prior product.



### **Supersede**

In addition to low risk changes in the API, a process needs to exist
to support breaking or higher risk changes in the API set.  Here is a
pretty typical solution to that problem that results in products and
APIs being superseded and defers retesting and migrating the
application to the API consumers.

```
T1. Stage Climbon V100 product with the Gold plan and Routes v100 API
T2. Publish Climbon v100 product
T3. Version Routes v200 API with a high risk and/or breaking change
T4. Version Climbon v200 product with Routes v200 API
T5. Stage Climbon V200
T6. Publish Climbon v200
T7. Deprecate Climbon v100
T8. Set Climbon v100 migration target to Climbon v200
T9. Allow each consumer of Climbon v100 to test against v200 and perform consumer side migration
T10. Once all consumers have migrated to Climbon v200, Retire/Remove Climbon v100
```

Similar to the replace macro operation, API Connect provides a single
macro CLI/REST operation to perform the relevant lifecycle operations
for a supersede in a single set.  Using this macro operation results
in the following:

```
T1. Stage Climbon V100 product with the Gold plan and Routes v100 API
T2. Publish Climbon v100 product
T3. Version Routes v200 API with a high risk and/or breaking change
T4. Version Climbon v200 product with Routes v200 API
T5. Stage Climbon V200
T6. Supersede Climbon v100 with Climbon v200
T7. Allow each consumer of Climbon v100 to test against v200 and perform consumer side migration
T8. Once all consumers have migrated to Climbon v200, Retire/Remove Climbon v100
```



### **Other**

Another thing to consider is that subsequent versions of a product may
take a very different shape than prior versions.  For example, as the
product version evolves, the referenced APIs may evolve, eg updated
API versions, new APIs, or different APIs altogether.  In addition,
plans may evolve as well.  Here's a simple product lifecycle for
consideration:

```
T1: Climbon v100 product with a Gold plan and Routes v100 API
T2: Climbon v101 product with a Gold plan and Routes v101 API with minor description text updates
T3: Climbon v110 product with a Gold plan and Routes v110 API containing new operations
T4: Climbon v200 product with a Premium and Freemium plans and Routes v200 API and Climbing Destinations v100 API
T4: Climbon v200 product is replaced by the Outdoors v300 product/Routes v200 API and Destinations v300 product/Climbing Destinations v300 API each with a single *Default* plan
```

To support these more complex scenario API Connect provides all the
basic building block CLIs and REST operations.  These operations can
be used to update the product state, set migration targets at a
product or plan level, or perform provider side migration tasks.
