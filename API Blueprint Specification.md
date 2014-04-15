---

Author: z@apiary.io
Version: 1A4

---

# API Blueprint
#### Format 1A revision 4

## [I. API Blueprint Language](#def-api-blueprint-language)
1. [Introduction](#def-introduction)
2. [API Blueprint](#def-api-blueprint)
3. [API Blueprint document](#def-api-blueprint-document)
4. [Blueprint section](#def-blueprint-section)
    1. [Section types](#def-section-types)
    2. [Section structure](#def-section-structure)
    3. [Keywords](#def-keywords)
    4. [Identifier](#def-identifier)
    5. [Description](#def-description)
    6. [Nested sections](#def-nested-sections)

## [II. Sections Reference](#def-sections-reference)
1. [Named section](#def-named-section)
2. [Asset section](#def-asset-section)
3. [Payload section](#def-payload-section)
4. [Headers section](#def-headers-section)
5. [Body section](#def-body-section)
6. [Schema section](#def-schema-section)
7. [Metadata section](#def-metadata-section)
8. [API name & overview section](#def-api-name-section)
9. [Resource group section](#def-resourcegroup-section)
10. [Resource section](#def-resource-section)
11. [Resource model section](#def-model-section)
12. [URI parameters section](#def-uriparameters-section)
13. [Action section](#def-action-section)
14. [Request section](#def-request-section)
15. [Response section](#def-response-section)

---

<br>

<a name="def-api-blueprint-language"></a>
# I. API Blueprint Language

<a name="def-introduction"></a>
## 1. Introduction
This documents is full specification of the API Blueprint format. For a less formal introduction to API Blueprint visit the [API Blueprint Tutorial](Tutorial.md) or check some of the [examples](examples).

<a name="def-api-blueprint"></a>
## 2. API Blueprint
API Blueprint is documentation-oriented web API description language. The API Blueprint is essentially a set of semantical assumptions laid on top of the Markdown syntax used to describe a web API.

In addition to the regular [Markdown syntax][] API Blueprint conforms to the [GitHub Flavored Markdown syntax][].

<a name="def-api-blueprint-document"></a>
## 3. API Blueprint document
An API Blueprint document – a blueprint is a plain text Markdown document describing a Web API or its part. The document is structured into logical **sections**. Each section has its distinctive meaning, content and position in the document. 

General section definition and structure is discussed in detail later in the [Blueprint section](#document-sections) chapter.

All of the blueprint sections are optional. However, when present, a section **must** follow the API Blueprint **document structure**.

### Blueprint document structure

+ [`0-1` **Metadata** section](#def-metadata-section)
+ [`0-1` **API Name & overview** section](#def-api-name-section)
+ [`0+` **Resource** sections](#def-resource-section)
    + [`0-1` **URI Parameters** section](#def-uriparameters-section)
    + [`0-1` **Model** section](#def-model-section)
    + [`1+` **Action** sections](#def-action-section)
        + [`0-1` **URI Parameters** section](#def-uriparameters-section)
        + [`0+` **Request** sections](#def-request-section)
            + [`0-1` **Headers** section](#def-headers-section)
            + [`0-1` **Body** section](#def-body-section)
            + [`0-1` **Schema** section](#def-schema-section)
        + [`1+` **Response** sections](#def-response-section)
            + [`0-1` **Headers** section](#def-headers-section)
            + [`0-1` **Body** section](#def-body-section)
            + [`0-1` **Schema** section](#def-schema-section)
+ [`0+` **Resource Group** sections](#def-resourcegroup-section)
    + [`0+` **Resource** sections](#def-resource-section) (see above)

> **NOTE:** The number prior to a section name denotes the allowed number of the section occurrences.

> **NOTE:** Refer to [Sections Reference](#def-sections-reference) for  description of a specific section type.

<a name="def-blueprint-section"></a>
## 4. Blueprint section
Section represents a logical unit of API Blueprint. For example an API overview, a group of resources or a resource definition. 

In general a section is **defined** using a **keyword** in a Markdown entity.
Depending on the type of section the keyword is written either as a Markdown header entity or in a list item entity. 

A section definition **may** also contain additional variable components such as its **identifier** and additional modifiers.

> **NOTE**: There are two special sections that are recognized by their position in the document instead of a keyword: The [Metadata section]() and the [API Name & Overview section](). Refer to the respective section entry for details on its definition.

#### Example: Header-defined sections

    # <keyword> 

     ...

    # <keyword> 

     ...

#### Example: List-defined sections

    + <keyword>

     ...
    
    + <keyword>

     ...

<a name="def-section-types"></a>
### 4.1 Section types
There are several types of API Blueprint sections. You can find the complete listing of the section types in the [Section Reference](#def-sections-reference).

**The Blueprint section chapter discusses the section syntax in general. A specific section type may conform only to some parts of this general syntax.** Always refer for respective section reference for details on its syntax.

<a name="def-section-structure"></a>
### 4.2 Section structure
A general structure of an API Blueprint section defined by a **keyword** includes an **identifier** (name), section **description** and **nested sections** or a specifically formatted content.

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
### 4.3 Keywords
Following reserved keywords are used in section definitions:

#### Header keywords
- `Group`
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

> **NOTE: Avoid using these keywords in other Markdown headers or lists**

> **NOTE:** With the exception of HTTP methods keywords the section keywords are case insensitive.

<a name="def-identifier"></a>
### 4.4 Identifier
A section definition **may** or **must** include an identifier of the section. An **identifier is any non-empty combination of any character except `[`, `]`, `(`, `)` and newline characters**.

An identifier **must not** contain any of the [keywords](#def-keywords).

#### Example

```
Adam's Message 42
```

```
my-awesome-message_2
```


<a name="def-description"></a>
### 4.5 Description
A section description is any arbitrary Markdown-formatted content following the section definition.

It is possible to use any Markdown header or list item in a section description as long as it does not clash with any of the [reserved keywords](#def-keywords). 

> **NOTE:** It is considered good practice to keep the header level nested under the actual section.

<a name="def-nested-sections"></a>
### 4.6 Nested sections
A section **may** contain another nested section(s). 

Depending on the nested section type, to nest a section simply increase its header level or its list item indentation. Anything between the section start and the start of following section at the same level is considered to be part of the section. 

What sections can be nested an where depends upon the section in case, as described in the relevant section's entry.

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

> **NOTE:** While not necessary it is a good habit to increase the level of a nested section markdown-header.

> **NOTE:** A markdown-list section is always considered to be nested under the preceding markdown-header section.

---

<a name="def-sections-reference"></a>
# II. Sections Reference
> **NOTE:** Sections marked as "Abstract" serve as a base for other sections and as such they **must not** be used directly.

<a name="def-named-section"></a>
## 1. Named section
- **Abstract**
- **Parent sections:** vary, see descendants
- **Nested sections:** vary, see descendants
- **Markdown entity:** header, list
- **Inherits from**: none

#### Definition
Defined by a [keyword](#def-keywords) followed by an optional section name - [identifier](#def-identifier) in a Markdown header or list entity.

```
# <keyword> <identifier>
```

```
+ <keyword> <identifier>
```

#### Description
Named section is the base section for most of the API Blueprint sections. It conforms to the [general section](#def-section-structure) and as such it composes of a section name (identifier), description and nested sections or specific formatted content (see descendants descriptions).

#### Example

    # <keyword> Section Name
    This the `Section Name` description.

    - one
    - **two**
    - three

    <nested sections> |  <formatted content>

---

<a name="def-asset-section"></a>
## 2. Asset section
- **Abstract**
- **Parent sections:** vary, see descendants
- **Nested sections:** none
- **Markdown entity:** list
- **Inherits from**: none

#### Definition
Defined by a [keyword](#def-keywords) in Markdown list entity.

    + <keyword>

#### Description
Asset section is the base section for atomic data in API Blueprint. The content this section is expected to be a [pre-formatted code block](http://daringfireball.net/projects/markdown/syntax#precode).

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
## 3. Payload section
- **Abstract**
- **Parent sections:** vary, see descendants
- **Nested sections:** [`0-1` Headers section](#def-headers-section), [`0-1` Body section](#def-body-section), [`0-1` Schema section](#def-schema-section)
- **Markdown entity:** list
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by a [keyword](#def-keywords) in Markdown list entity. The keyword **may** be followed by identifier. The definition **may** include payload's media-type enclosed in braces. 

    + <keyword> <identifier> (<media type>)

> **NOTE:** Refer to descendant for the particular section type definition.

#### Description
Payload sections represent the information transferred as a payload of an HTTP request or response messages. A Payload consists of optional meta information in the form of HTTP headers and optional content in the form HTTP body. 

Furthermore, in API Blueprint context, a payload include a description and a validation schema.

A payload section **may** have its media type associated. A payload's media type represents the metadata received or sent in the form of a HTTP `Content-Type` header. When specified a payload **should** include nested [Body section](#def-body-section).

This section **should** include at least one following nested sections:
 
- [`0-1` Headers section](#def-headers-section)
- [`0-1` Body section](#def-body-section)
- [`0-1` Schema section](#def-schema-section)

If there is no nested section the content of the payload section is considered as content of the [Body section](#def-body-section).

#### Referencing
Instead of providing a payload section content a previously defined [model payload section](#def-model-section) can be referenced using the Markdown implicit [reference syntax][]:

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

<a name="def-headers-section"></a>
## 4. Headers section
- **Parent sections:** [Payload section](#def-payload-section)
- **Nested sections:** none
- **Markdown entity:** list
- **Inherits from**: none

#### Definition
Defined by the `Headers` keyword in Markdown list entity.

    + Headers

#### Description
Specifies the HTTP message-headers of the parent payload section. The content this section is expected to be a [pre-formatted code block](http://daringfireball.net/projects/markdown/syntax#precode) with the following syntax:

    <HTTP header name>: <value>

One HTTP header per line.

#### Example

    + Headers

            Accept-Charset: utf-8
            Connection: keep-alive
            Content-Type: multipart/form-data, boundary=AaB03x

---

<a name="def-body-section"></a>
## 5. Body section
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

    + Body

            {
                "message": "Hello"
            }

---

<a name="def-schema-section"></a>
## 6. Schema section
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

<a name="def-metadata-section"></a>
## 7. Metadata section
- **Parent sections:** none
- **Nested sections:** none
- **Markdown entity:** special
- **Inherits from**: none

#### Definition
Key value pairs. Key separated from its value by colon (`:`). One pair per line.
Starts at the beginning of the document and ends with the first Markdown element that is not recognized as a key value pair.

#### Description
Metadata keys and its values are tool-specific. Refer to relevant tool documentation for the list of supported keys.

#### Example

    HOST: http://blog.acme.com
    FORMAT: 1A

---

<a name="def-api-name-section"></a>
## 8. API name & overview section
- **Parent sections:** none
- **Nested sections:** none
- **Markdown entity:** special, header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by the **first** Markdown header in the blueprint document unless it represents another section definition.

#### Description
Name and description of the API 

#### Example

    # Basic ACME Blog API
    Welcome to the **ACME Blog** API. This API provides access to the **ACME Blog** service.

---

<a name="def-resourcegroup-section"></a>
## 9. Resource group section
- **Parent sections:** none
- **Nested sections:** [`0+` Resource section](#def-resource-section)
- **Markdown entity:** header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by the `Group` keyword followed by group [name (identifier)](#def-identifier):

    # Group <identifier>

#### Description
This sections represents a group of resources (Resource Sections). **May** include one or more nested [Resource Sections](#def-resource-section).

#### Example

    # Group Blog Posts

    ## Resource 1 [/resource1]

     ...

    # Group Authors
    Resources in this groups are related to **ACME Blog** authors.    

    ## Resource 2 [/resource2]

     ...

---

<a name="def-resource-section"></a>
## 10. Resource section
- **Parent sections:** none, [Resource group section](#def-resourcegroup-section)
- **Nested sections:** [`0-1` Parameters section](#def-uriparameters-section), [`0-1` Model section](#def-model-section), [`1+` Action section](#def-action-section)
- **Markdown entity:** header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by an [RFC 6570 URI template][uritemplate]:

    # <URI template>

**-- or --**

Defined by a resource [name (identifier)](#def-identifier) followed by URI template enclosed in square brackets `[]`.

    # <identifier> [<URI template>]

**-- or --**

Defined by an [HTTP request method][httpmethods] followed by URI template:

    # <HTTP request method> <URI template>

> **NOTE:** In this case the rest of this section represents the [Action section](#def-action-section) including its description and nested sections and **follows the rules of Action section instead**.

#### Description
An API [resource](http://www.w3.org/TR/di-gloss/#def-resource) as specified by its *URI* or a set of resources (a resource template) matching its *URI template*.

This section **should** include at least one nested [Action section](#def-action-section) and **may** include following nested sections:
 
- [`0-1` Model section](#def-model-section)
- [`0-1` URI parameters section](#def-uriparameters-section)
- Additional [Action sections](#def-action-section)

> **NOTE:** A blueprint document may contain multiple sections for the same resource (or resource set), as long as their HTTP methods differ. However it is considered good practice to group multiple HTTP methods under one resource (resource set).

#### Example

```
# Blog Posts [/posts/{id}]
Resource representing **ACME Blog** posts.
```

```
# /posts/{id}
```

```
# GET /posts/{id}
```

---

<a name="def-model-section"></a>
## 11. Resource model section
- **Parent sections:** [Resource section](#def-resource-section)
- **Nested sections:** [Refer to payload section](#def-payload-section)
- **Markdown entity:** list
- **Inherits from**: [Payload section](#def-payload-section)

#### Definition
Defined by the `Model` keyword followed by an optional media type:

    + Model (<media type>)

#### Description
A [resource manifestation](http://www.w3.org/TR/di-gloss/#def-resource-manifestation) - one exemplar representation of the resource in the form of a [payload](#def-payload-section).

#### Referencing
The payload defined in this section **may** be referenced later using parent section's identifier. You can refer to this payload in any of the following [Request](#def-request-section) or [Response](#def-response-section) payload sections using the Markdown implicit [reference syntax][].

#### Example

    # My Resource [/resource]
    + Model (text/plain)
        
            Hello World
            
    ## Retrieve My Resource [GET]
    + Response 200
        
        [My Resource][]


---

<a name="def-uriparameters-section"></a>
## 12. URI parameters section
- **Parent Sections:** [Resource section](#def-resource-section) | [Action section](#def-action-section)
- **Nested Sections:** none
- **Markdown entity:** list
- **Inherits from**: none, special

#### Definition
Defined by the `Parameters` keyword written in a Markdown list item:

    + Parameters

#### Description
Discussion of parent section's URI parameters.

This section **must** be composed of nested list items only. This section **must not** contain any other elements. One list item per URI parameter. The nested list items subsections inherit from the [Named section](#def-named-section) and are subject to additional formatting as follows:

    + <parameter name> = `<default value>` (required | optional , <type>, `<example value>`) ... <description>

        <additional description>
        
        + Values
            + `<enumeration element 1>` 
            + `<enumeration element 2>`
            ...
            + `<enumeration element N>`

Where:

* `<parameter name>` is the parameter name as written in [Resource Section](#ResourceSection)'s URI (e.g. "id").
* `<description>` is any **optional** Markdown-formatted description of the parameter.
* `<additional description>` is any additional **optional** Markdown-formatted [description](#SectionDescription) of the parameter.
* `<default value>` is an **optional** default value of the parameter – a value that is used when no value is explicitly set (optional parameters only).
* `<example value>` is an **optional** example value of the parameter (e.g. `1234`).
* `<type>` is the **optional** parameter type as expected by the API (e.g. "number").
* `Values` is the **optional** enumeration of possible values
*  and `<enumeration element n>` represents an element of enumeration type.
* `required` is the **optional** specifier of a required parameter (this is the **default**)
* `optional` is the **optional** specifier of an optional parameter.

> **NOTE:** This section does not have to list every URI parameter. It **should not**, however, contain parameters that are not specified in the parents' URI template.

#### Example

```
# GET /posts/{id}
```

```
+ Parameters
    + id ... Id of a post.
```

```
+ Parameters
    + id (number) ... Id of a post.
```

```
+ Parameters
    + id (required, number, `1001`) ... Id of a post.
```

```
+ Parameters
    + id = `20` (optional, number, `1001`) ... Id of a post.
```

```
+ Parameters
    + id (string)

        Id of a Post

        + Values
            + `A`
            + `B`
            + `C`
```
---

<a name="def-action-section"></a>
## 13. Action section
- **Parent sections:** [Resource section](#def-resource-section)
- **Nested sections:** [`0-1` URI parameters section](#def-uriparameters-section), [`0+` Request section](#def-request-section), [`1+` Response section](#def-response-section)
- **Markdown entity:** header
- **Inherits from**: [Named section](#def-named-section)

#### Definition
Defined by an [HTTP request method][httpmethods]:

    ## <HTTP request method>

**-- or --**

Defined by an action [name (identifier)](#def-identifier) followed by an [HTTP request method][httpmethods] enclosed in square brackets `[]`.

    # <identifier> [<HTTP request method>]

#### Description
Definition of at least one complete HTTP transaction as performed with the parent resource section. An action section **may** consists of multiple HTTP transaction examples using the same HTTP request method.

This section **may** include one nested [URI parameters section](#def-uriparameters-section) describing any URI parameters specific to the action. It **should** include at least one nested [Response section](#def-response-section) and **may** include additional nested [Request](#def-request-section) and [Response](#def-response-section) sections. Multiple nested request and response sections **should** differ in their respective identifiers (status codes).

#### Example

    # Blog Posts [/posts{/id}]
    
     ...    

    ## Retrieve post [GET]
    Retrieves a **ACME Blog** posts.
    
    + Response 200

     ...

    ### Delete post [DELETE]
    + Response 204

     ...     

---

<a name="def-request-section"></a>
## 14. Request section
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

    + Request Create Blog Post (application/json)
        
            { "message" : "Hello World." }

---

<a name="def-response-section"></a>
## 15. Response section
- **Abstract**
- **Parent sections:** [Action section](#def-action-section)
- **Nested sections:** [Refer to payload section](#def-payload-section)
- **Markdown entity:** list
- **Inherits from**: [Payload section](#def-payload-section)

#### Definition
Defined by the `Response` keyword. The response section definition **should** include an [HTTP status code][] as its identifier.

    + Request <HTTP status code> (<Media Type>)

#### Description
One HTTP response-message example – payload.

#### Example

    + Response 201 (application/json)
        
                { "message" : "created" }

---

[apiblueprint.org]: http://apiblueprint.org
[markdown syntax]: http://daringfireball.net/projects/markdown
[reference syntax]: http://daringfireball.net/projects/markdown/syntax#link
[gitHub flavored markdown syntax]: https://help.github.com/articles/github-flavored-markdown
[httpmethods]: https://github.com/for-GET/know-your-http-well/blob/master/methods.md#know-your-http-methods-well
[uritemplate]: http://tools.ietf.org/html/rfc6570
[HTTP status code]: https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md
