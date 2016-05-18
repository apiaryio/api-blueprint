---

Author: z@apiary.io
Version: 1A9

---

# API Blueprint
#### Format 1A revision 9

## [I. API Blueprint Language](#def-api-blueprint-language)
+ [Introduction](#def-introduction)
+ [API Blueprint](#def-api-blueprint)
+ [API Blueprint document](#def-api-blueprint-document)
+ [Blueprint section](#def-blueprint-section)
    + [Section types](#def-section-types)
    + [Section structure](#def-section-structure)
    + [Keywords](#def-keywords)
    + [Identifier](#def-identifier)
    + [Description](#def-description)
    + [Nested sections](#def-nested-sections)

## [II. Sections Reference](#def-sections-reference)

### Abstract
+ [Named section](#def-named-section)
+ [Asset section](#def-asset-section)
+ [Payload section](#def-payload-section)

### Section Basics
+ [Metadata section](#def-metadata-section)
+ [API name & overview section](#def-api-name-section)
+ [Resource group section](#def-resourcegroup-section)
+ [Resource section](#def-resource-section)
+ [Resource model section](#def-model-section)
+ [Schema section](#def-schema-section)
+ [Action section](#def-action-section)
+ [Request section](#def-request-section)
+ [Response section](#def-response-section)
+ [URI parameters section](#def-uriparameters-section)
+ [Attributes section](#def-attributes-section)
+ [Headers section](#def-headers-section)
+ [Body section](#def-body-section)

### Going Further
+ [Data Structures section](#def-data-structures)
+ [Relation section](#def-relation-section)


## [III. Appendix](#def-appendix)
+ [URI Templates](#def-uri-templates)

---

<br>

<a name="def-api-blueprint-language"></a>
# I. API Blueprint Language

<a name="def-introduction"></a>
## Introduction
This documents is a full specification of the API Blueprint format. For a less
formal introduction to API Blueprint visit the 
[API Blueprint Tutorial](Tutorial.md) or check some of the [examples][].

<a name="def-api-blueprint"></a>
## API Blueprint
API Blueprint is a documentation-oriented web API description language. The
API Blueprint is essentially a set of semantic assumptions laid on top of the
Markdown syntax used to describe a web API.

In addition to the regular [Markdown syntax][], API Blueprint conforms to the
[GitHub Flavored Markdown syntax][].

<a name="def-api-blueprint-document"></a>
## API Blueprint document
An API Blueprint document – a blueprint – is a plain text Markdown document
describing a Web API in whole or in part. The document is structured into
logical **sections**. Each section has its distinctive meaning, content and
position in the document.

General section definition and structure is discussed in detail later in the
[Blueprint section](#def-blueprint-section) chapter.

All of the blueprint sections are optional. However, when present, a section
**must** follow the API Blueprint **document structure**.

### Blueprint document structure

+ [`0-1` **Metadata** section](#def-metadata-section)
+ [`0-1` **API Name & overview** section](#def-api-name-section)
+ [`0+` **Resource** sections](#def-resource-section)
    + [`0-1` **URI Parameters** section](#def-uriparameters-section)
    + [`0-1` **Attributes** section](#def-attributes-section)
    + [`0-1` **Model** section](#def-model-section)
        + [`0-1` **Headers** section](#def-headers-section)
        + [`0-1` **Attributes** section](#def-attributes-section)
        + [`0-1` **Body** section](#def-body-section)
        + [`0-1` **Schema** section](#def-schema-section)
    + [`1+` **Action** sections](#def-action-section)
        + [`0-1` **Relation** section](#def-relation-section)
        + [`0-1` **URI Parameters** section](#def-uriparameters-section)
        + [`0-1` **Attributes** section](#def-attributes-section)
        + [`0+` **Request** sections](#def-request-section)
            + [`0-1` **Headers** section](#def-headers-section)
            + [`0-1` **Attributes** section](#def-attributes-section)
            + [`0-1` **Body** section](#def-body-section)
            + [`0-1` **Schema** section](#def-schema-section)
        + [`1+` **Response** sections](#def-response-section)
            + [`0-1` **Headers** section](#def-headers-section)
            + [`0-1` **Attributes** section](#def-attributes-section)
            + [`0-1` **Body** section](#def-body-section)
            + [`0-1` **Schema** section](#def-schema-section)
+ [`0+` **Resource Group** sections](#def-resourcegroup-section)
    + [`0+` **Resource** sections](#def-resource-section) (see above)
+ [`0+` **Data Structures** section](#def-data-structures)

> **NOTE:** The number prior to a section name denotes the allowed number of
> the section occurrences.

> **NOTE:** Refer to [Sections Reference](#def-sections-reference) for
> description of a specific section type.

<a name="def-blueprint-section"></a>
## Blueprint section
A _Section_ represents a logical unit of an API Blueprint. For example: an API
overview, a group of resources or a resource definition.

In general a section is **defined** using a **keyword** in a Markdown entity.
Depending on the type of section the keyword is written either as a Markdown
header entity or in a list item entity.

A section definition **may** also contain additional variable components such
as its **identifier** and additional modifiers.

> **NOTE**: There are two special sections that are recognized by their
> position in the document instead of a keyword: The [Metadata section]() and
> the [API Name & Overview section](). Refer to the respective section entry
> for details on its definition.

#### Example: Header-defined sections

    # <keyword>

     ...

    # <keyword>

     ...


> **NOTE:** While this specification uses "atx" -style headers (using `#`s)
>  you can also use "Setext" [header syntax][] interchangeably:
>
>     <keyword>
>     =========
>
>     ...
>
>     <keyword>
>     =========
>
>     ...

#### Example: List-defined sections

    + <keyword>

     ...

    + <keyword>

     ...

> **NOTE:**  While this specification uses pluses (`+`) as list markers you can
> use any Markdown [list syntax][] using asterisks (`*`), pluses (`+`) and
> hyphens (`-`) interchangeably:
>
>     * <keyword>
>
>     ...
>
>     - <keyword>
>
>     ...

<a name="def-section-types"></a>
### Section types
There are several types of API Blueprint sections. You can find the complete
listing of the section types in the 
[Section Reference](#def-sections-reference).

**The Blueprint section chapter discusses the section syntax in general.**
**A specific section type may conform only to some parts of this general syntax.**
Always refer for respective section reference for details on its syntax.

<a name="def-section-structure"></a>
### Section structure
A general structure of an API Blueprint section defined by a **keyword**
includes an **identifier** (name), section **description** and **nested
sections** or a specifically formatted content.

#### Example: Header-defined section structure

    # <keyword> <identifier>

    <description>

    <specific content>

    <nested sections>

#### Example: List-defined section structure

    + <keyword> <identifier>

        <description>

        <specific content>

        <nested sections>

<a name="def-keywords"></a>
### Keywords
Following reserved keywords are used in section definitions:

#### Header keywords
- `Group`
- `Data Structures`
- [HTTP methods][httpmethods] (e.g. `GET, POST, PUT, DELETE`...)
- [URI templates][uritemplate] (e.g. `/resource/{id}`)
- Combinations of an HTTP method and URI Template (e.g. `GET /resource/{id}`)

#### List keywords
- `Request`
- `Response`
- `Body`
- `Schema`
- `Model`
- `Header` & `Headers`
- `Parameter` & `Parameters`
- `Values`
- `Attribute` & `Attributes`
- `Relation`

> **NOTE: Avoid using these keywords in other Markdown headers or lists**

> **NOTE:** With the exception of HTTP methods keywords the section keywords
> are case insensitive.

<a name="def-identifier"></a>
### Identifier
A section definition **may** or **must** include an identifier of the section.
An **identifier is any non-empty combination of any character except `[`, `]`,
`(`, `)` and newline characters**.

An identifier **must not** contain any of the [keywords](#def-keywords).

#### Example

```
Adam's Message 42
```

```
my-awesome-message_2
```


<a name="def-description"></a>
### Description
A section description is any arbitrary Markdown-formatted content following the
section definition.

It is possible to use any Markdown header or list item in a section description
as long as it does not clash with any of the 
[reserved keywords](#def-keywords).

> **NOTE:** It is considered good practice to keep the header level nested
> under the actual section.

<a name="def-nested-sections"></a>
### Nested sections
A section **may** contain another nested section(s).

Depending on the nested section type, to nest a section simply increase its
header level or its list item indentation. Anything between the section start
and the start of following section at the same level is considered to be part
of the section.

What sections can be nested and where depends upon the section in case, as
described in the relevant section's entry.

#### Example: Nested header-defined section

    # <section definition>

     ...

    ## <nested section definition>

     ...

#### Example: Nested list-defined section

    + <section definition>

         ...

        + <nested section definition>

         ...

> **NOTE:** While not necessary it is a good habit to increase the level of a
> nested section markdown-header.

> **NOTE:** A markdown-list section is always considered to be nested under the
> preceding markdown-header section.

---

<a name="def-sections-reference"></a>
# II. Sections Reference
> **NOTE:** Sections marked as "Abstract" serve as a base for other sections
> and as such they **cannot** be used directly.


# Abstract

<a name="def-named-section"></a>
## Named section
- **Abstract**
- **Parent sections:** vary, see descendants
- **Nested sections:** vary, see descendants
- **Markdown entity:** header, list
- **Inherits from**: none

#### Definition
Defined by a [keyword](#def-keywords) followed by an optional section name -
[identifier](#def-identifier) in a Markdown header or list entity.

```
# <keyword> <identifier>
```

```
+ <keyword> <identifier>
```

#### Description
Named section is the base section for most of the API Blueprint sections. It
conforms to the [general section](#def-section-structure) and as such it is
composed of a section name (identifier), description and nested sections or
specific formatted content (see descendants descriptions).

#### Example

    # <keyword> Section Name
    This the `Section Name` description.

    - one
    - **two**
    - three

    <nested sections> |  <formatted content>

---

<a name="def-asset-section"></a>
## Asset section
- **Abstract**
- **Parent sections:** vary, see descendants
- **Nested sections:** none
- **Markdown entity:** list
- **Inherits from**: none

#### Definition
Defined by a [keyword](#def-keywords) in Markdown list entity.

    + <keyword>

#### Description
The asset section is the base section for atomic data in API Blueprint. The content
of this section is expected to be a 
[pre-formatted code block](http://daringfireball.net/projects/markdown/syntax#precode).

#### Example

    + <keyword>

            {
                "message": "Hello"
            }

#### Example: Fenced code blocks

    + <keyword>

        ```
        {
            "message": "Hello"
        }
        ```

---

<a name="def-payload-section"></a>
## Payload section
- **Abstract**
- **Parent sections:** vary, see descendants
- **Nested sections:** [`0-1` Headers section](#def-headers-section), [`0-1` Attributes section](#def-attributes-section), [`0-1` Body section](#def-body-section), [`0-1` Schema section](#def-schema-section)
- **Markdown entity:** list
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by a [keyword](#def-keywords) in Markdown list entity. The keyword **may** be followed by identifier.
The definition **may** include payload's media-type enclosed in braces.

    + <keyword> <identifier> (<media type>)

> **NOTE:** Refer to descendant for the particular section type definition.

#### Description
Payload sections represent the information transferred as a payload of an HTTP
request or response messages. A Payload consists of optional meta information
in the form of HTTP headers and optional content in the form of an HTTP body.

Furthermore, in API Blueprint context, a payload includes its description,
description of its message-body attributes and a message-body validation
schema.

A payload **may** have its media type associated. A payload's media type
represents the metadata received or sent in the form of a HTTP `Content-Type`
header. When specified a payload **should** include nested 
[Body section](#def-body-section).

This section **should** include at least one of the following nested sections:

- [`0-1` Headers section](#def-headers-section)
- [`0-1` Attributes section](#def-attributes-section)
- [`0-1` Body section](#def-body-section)
- [`0-1` Schema section](#def-schema-section)

If there is no nested section the content of the payload section is considered
as content of the [Body section](#def-body-section).

#### Relation of Body, Schema and Attributes sections
Each of body, schema and attributes sections describe a message payload's body.
These descriptions **should** be consistent, not violating each other. When
multiple body descriptions are provided they **should** be prioritized as
follows:

1. For resolving message-body schema
    1. Schema section
    2. Attributes section
    3. Body section

2. For resolving message-body example
    1. Body section
    2. Attributes section
    3. Schema section

#### Referencing
Instead of providing a payload section content, a 
[model payload section](#def-model-section) can be referenced using the
Markdown implicit [reference syntax][]:

    [<identifier>][]

#### Example

    + <keyword> Payload Name (application/json)

        This the `Payload Name` description.

        + Headers

         ...

        + Body

         ...

        + Schema

        ...

#### Example: Referencing model payload

    + <keyword> Payload Name

        [Resource model identifier][]

---


# Section Basics


<a name="def-metadata-section"></a>
## Metadata section
- **Parent sections:** none
- **Nested sections:** none
- **Markdown entity:** special
- **Inherits from**: none

#### Definition
Key-value pairs. Each key is separated from its value by a colon (`:`). One
pair per line. Starts at the beginning of the document and ends with the first
Markdown element that is not recognized as a key-value pair.

#### Description
Metadata keys and their values are tool-specific. Refer to relevant tool
documentation for the list of supported keys.

#### Example

    FORMAT: 1A
    HOST: http://blog.acme.com

---

<a name="def-api-name-section"></a>
## API name & overview section
- **Parent sections:** none
- **Nested sections:** none
- **Markdown entity:** special, header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by the **first** Markdown header in the blueprint document, unless it
represents another section definition.

#### Description
Name and description of the API

#### Example

    # Basic ACME Blog API
    Welcome to the **ACME Blog** API. This API provides access to the **ACME
    Blog** service.

---

<a name="def-resourcegroup-section"></a>
## Resource group section
- **Parent sections:** none
- **Nested sections:** [`0+` Resource section](#def-resource-section)
- **Markdown entity:** header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by the `Group` keyword followed by group [name (identifier)](#def-identifier):

    # Group <identifier>

#### Description
This section represents a group of resources (Resource Sections). **May**
include one or more nested [Resource Sections](#def-resource-section).

#### Example

```apib
# Group Blog Posts

## Resource 1 [/resource1]

 ...

# Group Authors
Resources in this groups are related to **ACME Blog** authors.

## Resource 2 [/resource2]

 ...
```

---

<a name="def-resource-section"></a>
## Resource section
- **Parent sections:** none, [Resource group section](#def-resourcegroup-section)
- **Nested sections:** [`0-1` Parameters section](#def-uriparameters-section), [`0-1` Attributes section](#def-attributes-section), [`0-1` Model section](#def-model-section), [`1+` Action section](#def-action-section)
- **Markdown entity:** header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by an [URI template][uritemplate]:

    # <URI template>

**-- or --**

Defined by a resource [name (identifier)](#def-identifier) followed by an 
[URI template][uritemplate] enclosed in square brackets `[]`.

    # <identifier> [<URI template>]

**-- or --**

Defined by an [HTTP request method][httpmethods] followed by [URI template][uritemplate]:

    # <HTTP request method> <URI template>

**-- or --**

Defined by a resource [name (identifier)](#def-identifier) followed by an 
[HTTP request method][httpmethods] and an [URI template][uritemplate] enclosed
in square brackets `[]`:

    # <identifier> [<HTTP request method> <URI template>]

> **NOTE:** In the latter two cases the rest of this section represents the
> [Action section](#def-action-section) including its description and nested
> sections and **follows the rules of the Action section instead**.

#### Description
An API [resource](http://www.w3.org/TR/di-gloss/#def-resource) as specified by
its *URI* or a set of resources (a resource template) matching its *URI
template*.

This section **should** include at least one nested 
[Action section](#def-action-section) and **may** include following nested
sections:

- [`0-1` URI parameters section](#def-uriparameters-section)

    URI parameters defined in the scope of a Resource section apply to 
    _any and all_ nested Action sections except when an [URI template][uritemplate] has
    been defined for the Action.

- [`0-1` Attributes section][]

    Attributes defined in the scope of a Resource section represent Resource
    attributes. If the resource is defined with a name these attributes **may**
    be referenced in [Attributes sections][].

- [`0-1` Model section](#def-model-section)

- Additional [Action sections](#def-action-section)

> **NOTE:** A blueprint document may contain multiple sections for the same
> resource (or resource set), as long as their HTTP methods differ. However it
> is considered good practice to group multiple HTTP methods under one resource
> (resource set).

#### Example

```apib
# Blog Posts [/posts/{id}]
Resource representing **ACME Blog** posts.
```

```apib
# /posts/{id}
```

```apib
# GET /posts/{id}
```

---

<a name="def-model-section"></a>
## Resource model section
- **Parent sections:** [Resource section](#def-resource-section)
- **Nested sections:** [Refer to payload section](#def-payload-section)
- **Markdown entity:** list
- **Inherits from**: [Payload section](#def-payload-section)

#### Definition
Defined by the `Model` keyword followed by an optional media type:

    + Model (<media type>)

#### Description
A [resource manifestation](http://www.w3.org/TR/di-gloss/#def-resource-manifestation) - one
exemplary representation of the resource in the form of a
[payload](#def-payload-section).

#### Referencing
The payload defined in this section **may** be referenced in any response or
request section in the document using parent section's identifier. You can
refer to this payload in any of the following [Request](#def-request-section)
or [Response](#def-response-section) payload sections using the Markdown
implicit [reference syntax][].

#### Example

```apib
# My Resource [/resource]

+ Model (text/plain)

        Hello World

## Retrieve My Resource [GET]

+ Response 200

    [My Resource][]
```

---

<a name="def-schema-section"></a>
## Schema section
- **Parent sections:** [Payload section](#def-payload-section)
- **Nested sections:** none
- **Markdown entity:** list
- **Inherits from**: [Asset section](#def-asset-section)

#### Definition
Defined by the `Schema` keyword in Markdown list entity.

    + Schema

#### Description
Specifies a validation schema for the HTTP message-body of parent payload section.

---

<a name="def-action-section"></a>
## Action section
- **Parent sections:** [Resource section](#def-resource-section)
- **Nested sections:**
    [`0-1` Relation section](#def-relation-section),
    [`0-1` URI parameters section](#def-uriparameters-section),
    [`0-1` Attributes section](#def-attributes-section),
    [`0+` Request section](#def-request-section),
    [`1+` Response section](#def-response-section)
- **Markdown entity:** header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by an [HTTP request method][httpmethods]:

    ## <HTTP request method>

**-- or --**

Defined by an action [name (identifier)](#def-identifier) followed by an 
[HTTP request method][httpmethods] enclosed in square brackets `[]`.

    ## <identifier> [<HTTP request method>]

**-- or --**

Defined by an action [name (identifier)](#def-identifier) followed by an 
[HTTP request method][httpmethods] and 
[URI template][uritemplate] enclosed in square brackets `[]`.

    ## <identifier> [<HTTP request method> <URI template>]

#### Description
Definition of at least one complete HTTP transaction as performed with the
parent resource section. An action section **may** consist of multiple HTTP
transaction examples for the given HTTP request method.

This section **may** include one nested 
[URI parameters section](#def-uriparameters-section) describing any URI
parameters _specific_ to the action – URI parameters discussed in the scope of
an Action section apply to the respective Action section ONLY.

This section **may** include one nested [Attributes section][] defining the
input (request) attributes of the section. If present, these attributes
**should** be inherited in every Action's [Request section][] unless specified
otherwise.

Action section **should** include at least one nested 
[Response section](#def-response-section) and **may** include additional nested 
[Request](#def-request-section) and [Response](#def-response-section) sections.

Nested Request and Response sections **may** be ordered into groups where each
group represents one transaction example. The first transaction example group
starts with the first nested Request or Response section. Subsequent groups
start with the first nested Request section following a Response section.

Multiple Request and Response nested sections within one transaction example
**should** have different identifiers.

#### Example

```apib
# Blog Posts [/posts{?limit}]
 ...

## Retrieve Blog Posts [GET]
Retrieves the list of **ACME Blog** posts.

+ Parameters
    + limit (optional, number) ... Maximum number of posts to retrieve

+ Response 200

        ...

## Create a Post [POST]

+ Attributes

        ...

+ Request

        ...

+ Response 201

        ...

## Delete a Post [DELETE /posts/{id}]

+ Parameters
    + id (string) ... Id of the post

+ Response 204
```

#### Example Multiple Transaction Examples

```apib
# Resource [/resource]
## Create Resource [POST]

+ request A

        ...

+ response 200

        ...

+ request B

        ...

+ response 200

        ...

+ response 500

        ...

+ request C

        ...

+ request D

        ...

+ response 200

        ...
```

> **NOTE:** The "Multiple Transaction Examples" example demonstrates three
> transaction examples for one given action:
>
> 1. 1st example: request `A`, response `200`
> 2. 2nd example: request `B`, responses `200` and `500`
> 3. 3rd example: requests `C` and `D`, response `200`

---

<a name="def-request-section"></a>
## Request section
- **Parent sections:** [Action section](#def-action-section)
- **Nested sections:** [Refer to payload section](#def-payload-section)
- **Markdown entity:** list
- **Inherits from**: [Payload section](#def-payload-section)

#### Definition
Defined by the `Request` keyword followed by an optional [identifier](#def-identifier):

    + Request <identifier> (<Media Type>)

#### Description
One HTTP request-message example – payload.

#### Example

```apib
+ Request Create Blog Post (application/json)

        { "message" : "Hello World." }
```

---

<a name="def-response-section"></a>
## Response section
- **Parent sections:** [Action section](#def-action-section)
- **Nested sections:** [Refer to payload section](#def-payload-section)
- **Markdown entity:** list
- **Inherits from**: [Payload section](#def-payload-section)

#### Definition
Defined by the `Response` keyword. The response section definition **should**
include an [HTTP status code][] as its identifier.

    + Response <HTTP status code> (<Media Type>)

#### Description
One HTTP response-message example – payload.

#### Example

```apib
+ Response 201 (application/json)

            { "message" : "created" }
```

---

<a name="def-uriparameters-section"></a>
## URI parameters section
- **Parent Sections:** [Resource section](#def-resource-section) | [Action section](#def-action-section)
- **Nested Sections:** none
- **Markdown entity:** list
- **Inherits from**: none, special

#### Definition
Defined by the `Parameters` keyword written in a Markdown list item:

    + Parameters

#### Description
Discussion of URI parameters _in the scope of the parent section_.

This section **must** be composed of nested list items only. This section
**must not** contain any other elements. Each list item describes a single URI
parameter. The nested list items subsections inherit from the 
[Named section](#def-named-section) and are subject to additional formatting as
follows:

    + <parameter name>: `<example value>` (<type> | enum[<type>], required | optional) - <description>

        <additional description>

        + Default: `<default value>`

        + Members
            + `<enumeration value 1>`
            + `<enumeration value 2>`
            ...
            + `<enumeration value N>`

Where:

+ `<parameter name>` is the parameter name as written in 
  [Resource Section](#ResourceSection)'s URI (e.g. "id").
+ `<description>` is any **optional** Markdown-formatted description of the
  parameter.
+ `<additional description>` is any additional **optional** Markdown-formatted
  [description](#SectionDescription) of the parameter.
+ `<default value>` is an **optional** default value of the parameter – a value
  that is used when no value is explicitly set (optional parameters only).
+ `<example value>` is an **optional** example value of the parameter (e.g. `1234`).
+ `<type>` is the **optional** parameter type as expected by the API (e.g.
  "number", "string", "boolean"). "string" is the **default**.
+ `Members` is the **optional** enumeration of possible values.
  `<type>` should be surrounded by `enum[]` if this is present.
  For example, if enumeration values are present for a parameter whose type is
  `number`, then `enum[number]` should be used instead of `number` to.
+ `<enumeration value n>` represents an element of enumeration type.
+ `required` is the **optional** specifier of a required parameter 
  (this is the **default**)
+ `optional` is the **optional** specifier of an optional parameter.

> **NOTE:** This section **should only** contain parameters that are specified
> in the parent's resource URI template, and does not have to list every URI
> parameter.

#### Example

```apib
# GET /posts/{id}
```

```apib
+ Parameters
    + id - Id of a post.
```

```apib
+ Parameters
    + id (number) - Id of a post.
```

```apib
+ Parameters
    + id: `1001` (number, required) - Id of a post.
```

```apib
+ Parameters
    + id: `1001` (number, optional) - Id of a post.
        + Default: `20`
```

```apib
+ Parameters
    + id (enum[string])

        Id of a Post

        + Members
            + `A`
            + `B`
            + `C`
```
---

<a name="def-attributes-section"></a>
## Attributes Section
- **Parent sections:** [Resource section](#def-resource-section) | [Action section](#def-action-section) | [Payload section](#def-payload-section)
- **Nested sections:** See **[Markdown Syntax for Object Notation][MSON]**
- **Markdown entity:** list
- **Inherits from**: none

#### Definition
Defined by the `Attributes` keyword followed by an optional 
[MSON Type Definition][] enclosed in parentheses.

    + Attributes <Type Definition>

`<Type Definition>` is the type definition of the data structure being
described. If the `<Type Definition>` is not specified, an `object` base type
is assumed. See [MSON Type Definition][] for details.

##### Example

```apib
+ Attributes (object)
```

#### Description
This section describes a data structure using the 
**[Markdown Syntax for Object Notation][MSON] (MSON)**.
Based on the parent section, the data structure being described is one of the
following:

1. Resource data structure attributes ([Resource section](#def-resource-section))
2. Action request attributes ([Action section](#def-action-section))
3. Payload message-body attributes ([Payload section](#def-payload-section))

Data structures defined in this section **may** refer to any arbitrary data
structures defined in the [Data Structures section](#def-data-structures) as
well as to any data structures defined by a named resource attributes
description (see below).

#### Resource Attributes description
Description of the resource data structure.

If defined in a named [Resource section](#def-resource-section), this data
structure **may** be referenced by other data structures using the resource
name.

##### Example

```apib
# Blog Post [/posts/{id}]
Resource representing **ACME Blog** posts.

+ Attributes
    + id (number)
    + message (string) - The blog post article
    + author: john@appleseed.com (string) - Author of the blog post
```

> **NOTE:** This data structure can be later referred as:
>
>     + Attributes (Blog Post)
>

#### Action Attributes description
Description of the default request message-body data structure.

If defined, all the [Request sections](#def-request-section) of the respective
[Action section](#def-action-section) inherits these attributes unless
specified otherwise.

##### Example

```apib
## Create a Post [POST]

+ Attributes
    + message (string) - The blog post article
    + author: john@appleseed.com (string) - Author of the blog post

+ Request (application/json)

+ Request (application/yaml)

+ Response 201
```

#### Payload Attributes description
Description of payload (request, response, model) message-body attributes.

Not every attribute has to be described. However, when an attribute is
described, it **should** appear in the respective 
[Body section](#def-body-section) example, if a Body section is provided.

If defined, the [Body section](#def-body-section) **may** be omitted and the
example representation **should** be generated from the attributes description.

The description of message-body attributes **may** be used to describe
message-body validation if no [Schema section](#def-schema-section) is
provided. When a Schema section is provided, the attributes description
**should** conform to the schema.

##### Example

```apib
## Retrieve a Post [GET]

+ Response 200 (application/json)

    + Attributes (object)
        + message (string) - Message to the world

    + Body

            { "message" : "Hello World." }
```

---

<a name="def-headers-section"></a>
## Headers section
- **Parent sections:** [Payload section](#def-payload-section)
- **Nested sections:** none
- **Markdown entity:** list
- **Inherits from**: none

#### Definition
Defined by the `Headers` keyword in Markdown list entity.

    + Headers

#### Description
Specifies the HTTP message-headers of the parent payload section. The content
this section is expected to be a [pre-formatted code block](http://daringfireball.net/projects/markdown/syntax#precode)
with the following syntax:

    <HTTP header name>: <value>

One HTTP header per line.

#### Example

```apib
+ Headers

        Accept-Charset: utf-8
        Connection: keep-alive
        Content-Type: multipart/form-data, boundary=AaB03x
```

---

<a name="def-body-section"></a>
## Body section
- **Parent sections:** [Payload section](#def-payload-section)
- **Nested sections:** none
- **Markdown entity:** list
- **Inherits from**: [Asset section](#def-asset-section)

#### Definition
Defined by the `Body` keyword in Markdown list entity.

    + Body

#### Description
Specifies the HTTP message-body of a payload section.

#### Example

```apib
+ Body

        {
            "message": "Hello"
        }
```

---


<a name="def-data-structures"></a>
## Data Structures section
- **Parent sections:** none
- **Nested sections:** _MSON Named Type definition_ (see below)
- **Markdown entity:** header
- **Inherits from**: none

#### Definition
Defined by the `Data Structures` keyword.

    # Data Structures

#### Description
This section holds arbitrary data structures definitions defined in the form of
[MSON Named Types][].

Data structures defined in this section **may** be used in any [Attributes section][].
Similarly, any data structures defined in a [Attributes section][] of a named
[Resource Section][] **may** be used in a data structure definition.

Refer to the [MSON][] specification for full details on how to define an MSON Named type.

#### Example

```apib
# Data Structures

## Message (object)

+ text (string) - text of the message
+ author (Author) - author of the message

## Author (object)

+ name: John
+ email: john@appleseed.com
```

#### Example reusing Data Structure in Resource

```apib
# User [/user]

+ Attributes (Author)

# Data Structures

## Author (object)

+ name: John
+ email: john@appleseed.com
```

#### Example reusing Resource-defined Data Structure

```apib
# User [/user]

+ Attributes
    + name: John
    + email: john@appleseed.com

# Data Structures

## Author (User)
```

---

<a name="def-relation-section"></a>
## Relation section
- **Parent sections:** [Action section](#def-action-section)
- **Nested Sections:** none
- **Markdown entity:** list
- **Inherits from**: none

#### Definition
Defined by the `Relation` keyword written in a Markdown list item followed by a
colon (`:`) and a link relation identifier.

    + Relation: <link relation identifier>

#### Description
This section specifies a [link relation type](https://tools.ietf.org/html/rfc5988#section-4)
for the given action as specified by [RFC 5988](https://tools.ietf.org/html/rfc5988).

> **NOTE:** The link relation identifiers should be unique per resource in the blueprint document.

#### Example

```apib
# Task [/tasks/{id}]

+ Parameters
    + id

## Retrieve Task [GET]

+ Relation: task
+ Response 200

        { ... }

## Delete Task [DELETE]

+ Relation: delete
+ Response 204
```

---


<br>

<a name="def-appendix"></a>
# III. Appendix

<a name="def-uri-templates"></a>
## URI Templates

The API Blueprint uses a subset of [RFC6570][rfc6570] to define a resource URI Template.

### URI Path Segment

At its simplest form – without any variables – a path segment of an 
URI Template is identical to an URI path segment:

```
/path/to/resources/42
```

### URI Template Variable

Variable names are case-sensitive. The variable name may consists of following
characters **only**:

- ASCII alpha numeric characters (`a-z`, `A-Z`)
- Decimal digits (`0-9`)
- `_`
- [Percent-encoded][pct-encoded] characters
- `.`

Multiple variables are separated by the comma **without** any leading or
trailing spaces. A variable(s) **must** be enclosed in braces – `{}`
**without** any additional leading or trailing whitespace.

#### Operators

The first variable in the braces **might** be preceded by an operator. 
API Blueprint currently supports the following operators:

- `#` – _fragment identifier_ operator
- `+` – _reserved value_ operator
- `?` – _form-style query_ operator
- `&` – _form-style query continuation_ operator

#### Examples

```
{var}
{var1,var2,var3}
{#var}
{+var}
{?var}
{?var1,var2}
{?%24var}
{&var}
```

> **NOTE:** The [explode variable modifier][uri-explode] is also supported.
> Refer to RFC6570 for its description.

#### Variable Reserved Values

Following characters are **reserved** in variable _values_:

`:` / `/` / `?` / `#` / `[` / `]` / `@` / `!` / `$` / `&` / `'` / `(` / `)` / `*` / `+` / `,` / `;` / `=`

### Path Segment Variable

Simple path segment component variable is defined without any operator:

```
/path/to/resources/{var}
```

With `var := 42` the expansion is `/path/to/resources/42`.

> **NOTE:** RFC6570 – Level 1

### Fragment Identifier Variable

URI Template variables for fragment identifiers are defined using the
crosshatch (`#`) operator:

```
/path/to/resources/42{#var}
```

With `var := my_id` the expansion is `/path/to/resources/42#my_id`.

> **NOTE:** RFC6570 – Level 2

### Variable with Reserved Characters Values

To define URI Template variables with reserved URI characters,
use the plus (`+`) operator:

```
/path/{+var}/42
```

With `var := to/resources` the expansion is `/path/to/resources/42`.

> **NOTE:** RFC6570 – Level 2

### Form-style Query Variable

To define variables for a form-style query use the question mark (`?`) operator

```
/path/to/resources/{varone}{?vartwo}
```

With `varone := 42` and `vartwo = hello` the expansion is `/path/to/resources/42?vartwo=hello`.

To continue a form-style query use the ampersand (`&`) operator:

```
/path/to/resources/{varone}?path=test{&vartwo,varthree}
```

With `varone := 42`, `vartwo = hello`, `varthree = 1024` the expansion is `/path/to/resources/42?path=test&vartwo=hello&varthree=1024`.

> **NOTE:** RFC6570 – Part of Level 3

---

[apiblueprint.org]: http://apiblueprint.org
[markdown syntax]: http://daringfireball.net/projects/markdown
[reference syntax]: http://daringfireball.net/projects/markdown/syntax#link
[gitHub flavored markdown syntax]: https://help.github.com/articles/github-flavored-markdown
[httpmethods]: https://github.com/for-GET/know-your-http-well/blob/master/methods.md#know-your-http-methods-well
[uritemplate]: #def-uri-templates
[rfc6570]: http://tools.ietf.org/html/rfc6570
[HTTP status code]: https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md
[header syntax]: https://daringfireball.net/projects/markdown/syntax#header
[list syntax]: https://daringfireball.net/projects/markdown/syntax#list
[pct-encoded]: http://en.wikipedia.org/wiki/Percent-encoding
[uri-explode]: http://tools.ietf.org/html/rfc6570#section-2.4.2
[examples]: https://github.com/apiaryio/api-blueprint/tree/master/examples

[MSON]: https://github.com/apiaryio/mson
[MSON Named Types]: https://github.com/apiaryio/mson/blob/master/MSON%20Specification.md#22-named-types
[MSON Type Definition]: https://github.com/apiaryio/mson/blob/master/MSON%20Specification.md#35-type-definition

[`0-1` Attributes section]: #def-attributes-section
[Attributes section]: #def-attributes-section
[Attributes sections]: #def-attributes-section

[Resource Section]: #def-resource-section

[Request section]: #def-request-section
