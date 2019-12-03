# API Products

Authors:
- [Shane Claussen](mailto:claussen@us.ibm.com), Chief Architect, API Connect
- [Sumanto Biswas](mailto:biswas@us.ibm.com), Development Lead, API Connect



# Introduction

Products are used to package APIs into a set of consumption plans to
power the API lifecycle.



# Overview

Products draw from both business and technical disciplines.  At a
business level, they enable product managers the flexibility to
compose multiple APIs together into a single unit, create consumption
tiers to target different developer communities, and fine tune
visiblity controls to target broad based or fine grained developer
communities.  Technically, products are the primary unit of lifecycle
management.  They have first class versioning capability enabling
publishing, co-publishing, and subscription migration use cases and a
set of runtime states to provide full cradle to grave lifecycle
management.



# Creation

You can create product and API definitions by using our graphical design
tool named API Designer, our online API Manager, or via the command line.

Here is a simple boiler plate product definition referencing two
OpenAPI definitions with a single plan all serialized into a YAML
file:

```
product: '1.0.0'

info:
  name: climbon
  title: ClimbOn
  version: 1.0.0

apis:
  'routes':
    $ref: routes.yaml
  'ascents':
    $ref: ascents.yaml

visibility:
  view:
    type: public
  subscribe:
    type: authenticated

plans:
  default:
    title: Default Plan
    description: Default Plan
    approval: false
    rate-limit:
      value: 100/hour
      hard-limit: false
```



# Info

Below is a more complete and self explanatory example of a product
info section:

```
info:
  name: climbon
  title: ClimbOn
  version: 1.0.0
  description: 'This is the description of my **really cool** API.'
  contact:
    name: Shane Claussen
    email: claussen@us.ibm.com
    url: 'https://developer.ibm.com/apiconnect'
  license:
    name: This is the license name
    url: 'https://developer.ibm.com/apiconnect'
  termsOfService: Here are the terms of service ...
```

The identity of the product is the combination of the name and the
version values in the info section (e.g. climbon:1.0.0).  The product
version value is typically defaulted to 1.0.0 based on the [Semantic
Versioning](http://semver.org) MAJOR.MINOR.PATCH syntax.



# APIs

The APIs section references the OpenAPI definitions composed by this
product.  The name 'routes' and 'ascents' are local to the product
definition and can be used to discriminate API consumption details at
the plan level.  In order to be published to an API Connect catalog,
API products need to reference atleast one API.

```
apis:
  'routes':
    $ref: routes.yaml
  'ascents':
    $ref: ascents.yaml
```



# Visibility

The product visibility section enables product managers to control the
visibility of API products published to the developer portal.  When
the API product is created it the visibility is defaulted as follows:

```
visibility:
  view:
    type: public
  subscribe:
    type: authenticated
```

The view permission defines who can view the API product in the
developer portal and the subscribe permission describes who can
subscribe to the API product.  The default permissions enable all
unauthenticated application developers to see the product but require
developers to be authenticated to create a subscription.

In addition to the public and authenticated values the visibility
settings can be more fine grained.  Each permission can be customized
for specific developer organizations or communities of developer
organizations.  The developer organization and community names
required to support finer grained permissions can be found in the
catalog's developer page using the API Manager application.

Below is an example of a product with restricted visibility.  Only
four developer communities can view the product (listed in the tags
section), and only the gold-partners community of developer
organizations and the developer1 organization are allowed to subscribe
to the product.

```
visibility:
  view:
    type: custom
    tags:
      - gold-partners
      - silver-partners
      - bronze-partners
      - non-partners
  subscribe:
    type: custom
    tags:
      - gold-partners
    orgs:
      - developer1
```



# Plans

Developers obtain a product by subscribing to one of the plans
described in the product definition's plans section.  Products must
contain atleast one plan to be published.  Each plan has the following
fields:

- **name**: identity of the plan
- **title**: display name of the plan
- **description**: description of the plan
- **approval**: does plan subscription require product manager approval
- **rate-limit.value**: rate limiting value
- **rate-limit.hard-limit**: are HTTP 429s returned upon exceeding the rate limit

Below is the plan named default that's generated when a product is created:

```
plans:
  default:
    title: Default Plan
    description: Default Plan
    approval: false
    rate-limit:
      value: 100/hour
      hard-limit: true
```

Beyond the per plan approval and rate limiting capabilities, each plan
also has an optional `apis` section that can be used to limit the APIs
provided by the plan to a subset of the APIs defined by the product
and/or provide more fine grained operation level rate limiting.

The following is a sample of a more complex set of plans:

```
plans:

  bronze:
    title: Bronze Plan
    description: Bronze Plan
    approval: false
    rate-limit:
      value: 100/hour
      hard-limit: true
    apis:
      routes:
        operations:
          - operation: get
            path: /routes
          - operation: get
            path: '/routes/{route}'

  silver:
    title: Silver Plan
    description: Silver Plan
    approval: true
    rate-limit:
      value: 1000/hour
      hard-limit: true
    apis:
      ascents:
        operations:
          - operation: post
            path: /ascents
          - operation: get
            path: /ascents
            rate-limit:
              value: 250/1hour
              hard-limit: true
          - operation: get
            path: '/ascents/{user}'
          - operation: patch
            path: '/ascents/{user}'
          - operation: delete
            path: '/ascents/{user}'
      routes:
        operations:
          - operation: get
            path: /routes
            rate-limit:
              value: 250/1hour
              hard-limit: true
          - operation: get
            path: '/routes/{route}'

  gold:
    title: Gold Plan
    description: Gold Plan
    approval: true
    rate-limit:
      value: 10000/hour
      hard-limit: false
```

The *bronze* plan is a relatively limited plan targeting a large
community of developers.  It restricts developers to the the routes
list and retrieve operations using a limited rate limit (the ascents
API and its operations are not made available to the bronze tier).  To
simplify the developer onboarding process the product manager does not
require subscription approval.

The *silver* plan enables developers to use all of the ascents API's
operations to create a personalized ascent record, but the plan
prohibits the update operations on the routes API used to add, update,
and delete routes.  The silver plan also enables a more liberal rate
limit than bronze (although not as favorable as gold).  In addition, a
fine grained rate limit for the routes and ascents list operations has
been added (this might be done due to the server load of particular
operations).  Due to its power the product manager has decided to
require subscription approval.

The *gold* plan excludes the apis section in the plan altogether,
enabling developers to access all operations from all the APIs defined
in the product definition.  A much more permissive rate limit is
provided with the gold plan and there's no longer a hard limit
enabling developers to exceed the limit.  Again, due to the power of
this API it requires approval.
