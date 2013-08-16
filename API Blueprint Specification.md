Author: z@apiary.io

# API Blueprint Language Specification

## Revision 1A

---

## Contents
1. [Introduction](#Introduction)
2. [API Blueprint Language](#Language)
3. [API Blueprint Document](#Document)
	1. [Sections](#Sections)
	2. [Reserved Section Names](#ReservedSectionNames)
	3. [Nested sections](#NestedSections)
	4. [Other Markdown headers](#OtherMarkdownHeaders)
	5. [Special Sections](#SpecialSections)
4. [API Blueprint Document Structure](#DocumentStructure)
	1. [Metadata Section](#MetadataSection)
	2. [API Name & Overview Section](#APINameOverviewSection)
	3. [Resource Section](#ResourceSection)
		1. [Parameters Section](#ResourceParametersSection)
		2. [Method Section](#ResourceMethodSection)
		3. [Request Section](#ResourceRequestSection)
		4. [Response Section](#ResourceResponseSection)
		5. [Headers Section](#ResourceHeadersSection)
		6. [Object Section](#ResourceObjectSection)
	4. [Grouping resources](#ResourceGroups)
5. [Payloads](#Payloads)
	1. [Headers Subsection](#PayloadHeadersSection)
	2. [Parameters Subsection](#PayloadParametersSection)
	3. [Body Subsection](#PayloadBodySection)
	4. [Schema Subsection](#PayloadSchemaSection)
6. [Assets](#DocumentAssets)
	1. [Inline Asset](#InlineDocumentAsset)

---
<a name="Introduction"></a>
## 1. Introduction
This document is a full specification of the [API Blueprint](http://apiblueprint.org) Language (hereafter "API Blueprint"). API Blueprint is a **Web API documentation language**.

Please refer to the [API Blueprint homepage](http://apiblueprint.org) for an introduction to API Blueprint.

---

<a name="Language"></a>
## 2. API Blueprint
API Blueprint is essentially a set of semantical assumption on top of a [Markdown](http://daringfireball.net/projects/markdown) syntax that are used to define a Web API. 

In additional to regular Markdown syntax API Blueprint inherits some [MultiMarkdown](http://fletcherpenney.net/multimarkdown) and [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown) features.

Before you proceed with this document please make yourself familiar with the basic [Markdown Syntax](http://daringfireball.net/projects/markdown/syntax) as well as with the Metadata and Cross-References sections of [MultiMarkdown Syntax](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#multimarkdown-syntax-guide) and GitHub Flavored Markdown's [newlines & fenced code blocks](https://help.github.com/articles/github-flavored-markdown).

---

<a name="Document"></a>
## 3. API Blueprint Document
API Blueprint document is a Markdown document where you define and describe a Web API.

The document itself is divided into several logical **sections** which represent the **API Blueprint Document Structure**.

<a name="Sections"></a>
### 3.1. Sections
A section represents a logical unit of your API Blueprint. For example an API overview, a group of resources or a resource definition. A section can contain other (nested) section. For example a resource definition might contain a resource URI parameter's description as its subsection.

Sections are recognized by a **reserved section name** or a **URI template** in a **Markdown header**. Alternatively some sections might be recognized by a **reserved section name** in a **Markdown list item** followed by a newline.

Each section or subsection has a strictly defined name, meaning and expected content. Anything between a section start and another section start is considered to be part of the section. This implies that you **must avoid** using reserved section names – **keywords** in other Markdown headers but section headers.

<a name="ReservedSectionNames"></a>
### 3.2. Reserved Section Names
Reserved keywords are:

- Markdown Headers:
	- HTTP methods: `GET, POST, PUT, DELETE, OPTIONS, PATCH, PROPPATCH, LOCK, UNLOCK, COPY, MOVE, MKCOL, HEAD`
	- URI templates (e.g. `/resource/{id}`)
	- Combinations of HTTP method and URI Template (e.g. `GET /resource/{id}`)

- Markdown List items: 
	- `Request`
	- `Response`
	- `Header` & `Headers`
	- `Parameter` & `Parameters`
	- `Body`
	- `Schema`
	- `Object`
	- `Group`

Sections are discussed in [API Blueprint Document Structure](#DocumentStructure). Note that some section names can contain variable components such as identifiers or other modifiers. See the relevant section's entry to find out more about how its section name is built.

<a name="NestedSections"></a>
### 3.3. Nested Sections
Some sections can or must be nested inside another section. To nest a section simply **increase** its **header level** and / or **list item indentation**.

Example:

	# Section A
	... Section A content ...

	## Nested Section of Section A
	... Nested Section content ...

	# Section B
	... Section B content...
	
Nested List Item Sections:
	
	+ Section C
	  ... Section C content...

		+ Section D
		  ... Section D content...

Which sections can be nested depends upon the section in case, as described in the relevant [API Blueprint Document Structure](#DocumentStructure) section's entry.

<a name="OtherMarkdownHeaders"></a>
### 3.4. Other Markdown Headers
It is possible to use any Markdown header at any point in a section description as long as it does not clash with the [Reserved Section Names](#ReservedSectionNames). It is considered good practice to keep your header level nested to your actual section.

<a name="SpecialSections"></a>
### 3.5. Special Sections
There are **two additional** sections of an API Blueprint Document that are not recognized by any keyword: The [Metadata Section](#MetadataSection) and the [API Name & Overview](#APINameOverviewSection). These are discussed in the [API Blueprint Document Structure](#DocumentStructure).

---

<a name="DocumentStructure"></a>
## 4. API Blueprint Document Structure
Bellow you will find a description of each section of the API Blueprint Document. Note that all sections are, by default, optional. However, the document should contain at least one [Resource](#ResourceSection) Section.

An example of a possible API Blueprint Document layout:

	Metadata: ...

	# API Name
	...
	
	---
	
	# Group 1
	...
	## Resource 1.1
	...
	+ Parameters
	...
	+ Request
	...
	+ Response
	...
	## Resource 1.2
	...
	+ Response
	...
	# Group 2
	...
	+ Resource 2.1
	...

<a name="MetadataSection"></a>
### 4.1. Metadata Section
**Optional**. API metadata.

This section is **recognized** as [MultiMarkdown Metadata](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#metadata). It starts from the beginning of the document and ends with the first Markdown element that is not recognized as MutliMarkdown Metadata.

This section **does not include** any **other sections**.

#### Supported Metadata
* **`Host` (or `HOST`)** *(optional)* ... API server hostname.
* **`Format`(or `FORMAT`)** *(optional)* ... API Blueprint version. Leave blank for legacy format. Use `1A` for actual version.

Example:

	HOST: http://blog.acme.com
	FORMAT: 1A

<a name="APINameOverviewSection"></a>
### 4.2. API Name & Overview Section
**Optional**. Name of the API in the form of a Markdown header.

This section is **recognized** as the **first** Markdown header in your document and its name is considered to be your **API name**.

This section can contain **further Markdown-formatted content**. If content is provided it is considered to represent the API Overview description. 

This section **does not include** any **other sections**.

Example:

	# My API Name

	-- or --

	# Basic ACME Blog API
	Welcome to the **ACME Blog** API. This API provides access to the **ACME Blog** service.

<a name="ResourceSection"></a>
### 4.3. Resource Section
**Optional**. Definition of exactly **one** API [**resource**](http://www.w3.org/TR/di-gloss/#def-resource) specified by its *URI* **OR** a **set of resources** (a resource template) matching its *URI template*.

Your Blueprint document can contain multiple sections for the same resource (resource cluster) - URI (URI template), as long as their HTTP methods differ. However it is considered good practice to group multiple HTTP methods under one resource (resource cluster).

This section is **recognized** by an [RFC 6570 URI template](http://tools.ietf.org/html/rfc6570) written in a Markdown header. Optionally the header can contain **one** leading [HTTP Request Method](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) in which case the rest of this section is considered to represent the [Method Section](#ResourceMethodSection).

Alternatively this section is **recognized** by a MultiMarkdown header with URI Template specified in its [explicit label](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references).

This section can contain **further Markdown-formatted content**. If content is provided it is considered to represent the Resource description.

If no **HTTP Request Method** is specified, this section **should include** at least one nested [Method Section](#ResourceMethodSection).

In addition to any mandatory nested sections this section **may include** the following additional subsections:
 
* [Parameters Section](#ResourceParametersSection)
* Nested [Method Section](#ResourceMethodSection),  if **no** HTTP Request Method is specified
* [Headers Section](#ResourceHeadersSection)
* [Object Section](#ResourceObjectSection)

Example:

	# PUT /posts

	-- or --

	# GET /posts{/id}

	-- or --

	# /posts
	
	-- or --
	
	# My Resource [/resource]

<a name="ResourceParametersSection"></a>
#### 4.3.1. Parameters Section
**Optional**. Description of [Resource Section](#ResourceSection)'s URI parameters. Content of this section is subject to additional formatting.

This subsection is **recognized** by the `Parameters` reserved **keyword** written as a Markdown list item. If present, it must be subsection of a [Resource Section](#ResourceSection).

This subsection can contain **further Markdown-formatted content**. If content is provided it is considered to represent a general Resource URI parameter description. The rest of this subsection is formatted as follows:

	+ <parameter name> [= <default value>] [<type> [,(required | optional)]] ... Markdown-formatted content

Where:

* `<parameter name>` is the parameter name as written in [Resource Section](#ResourceSection)'s URI (e.g. "id").
* `<default value>` is the **optional** parameter default or example value (e.g. 1234).
* `<type>` is the **optional** parameter type as expected by your API (e.g. "number").
* `required` is the **optional** specifier of a required parameter
* `optional` is the **optional** specifier of an optional parameter

This subsection does not have to list every URI parameter. It **should not**, however, contain parameters that are not specified in the URI.

This subsection **does not include** any **other subsection**.

Example:

	# GET /posts{/id}
	+ Parameters
		+ id ... Id of a post.

	-- or --

		+ id = 1234 ... Id of a post.

	-- or --

		+ id (number) ... Id of a post.

	-- or --

		+ id = 1234 (number, required) ... Id of a post.

<a name="ResourceMethodSection"></a>
#### 4.3.2. Method Section
**Expected** if there is no HTTP method specified in the [Resource Section](#ResourceSection)'s header. **Illegal** otherwise. [HTTP Request Methods](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) available for this Resource.

This section is **recognized** by one of the [HTTP Request Methods](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) written in capitals as a Markdown header.

Alternatively this section is **recognized** by a MultiMarkdown header with a HTTP Request Method specified in its [explicit label](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references).

This section can contain **further Markdown-formatted content**. If content is provided it is considered to represent this Resource's method description.

This section **should include** at least one [Response Subsection](#ResourceResponseSection). In addition to the mandatory nested section this section **may include** the following additional subsections:
 
* [Parameters Section](#ResourceParametersSection)
* [Request Section](#ResourceRequestSection), if a HTTP Request Method is specified
* [Response Section](#ResourceResponseSection), if a HTTP Request Method is specified
* [Headers Section](#ResourceHeadersSection)

One [Resource Section](#ResourceSection) can contain **one or more different** Method Sections.

Example:

	# /posts{/id}
	+ Parameters
	...

	## GET
	Retrieves a **ACME Blog** posts.
	...

	## PUT
	...
	
	### Delete post [DELETE]
	...

<a name="ResourceRequestSection"></a>
#### 4.3.3. Request Section
**Optional**. Description of exactly *one* [HTTP request](http://www.w3.org/TR/di-gloss/#def-http-request).

This section is **recognized** by the `Request` reserved **keyword** written in a Markdown header. The **"Request"** can be followed by an arbitrary string representing the user identifier of this request. This identifier **must not** be enclosed in brackets. In case a HTTP body is specified the `Request` keyword (and possible identifier) **should be** followed by a HTTP Body [Media Type (MIME type)](http://en.wikipedia.org/wiki/Internet_media_type).

The Full Request Subsection list syntax is as follows:

	+ Request [<identifier>] [(<Media Type>)]

This subsection is a specific type of [Payload](#Payloads) carried by this request. See [Payloads Documentation](#Payloads) for details about how to specify the content of this section.

One [Resource Section](#ResourceSection) or [Method Section](#ResourceMethodSection) can contain **one or more different** (that is with different identifiers) Request Subsections.

Example:

	+ Request (text/plain)
		
			Hello World

	-- or --

	+ Request Create Blog Post (application/json)
	    
	    	{ "message" : "Hello World." }

<a name="ResourceResponseSection"></a>
#### 4.3.4. Response Section
**Expected**. Description of exactly *one* [HTTP response](http://www.w3.org/TR/di-gloss/#def-http-response).

This subsection is **recognized** by the `Response` reserved **keyword** written in a Markdown list followed by a [HTTP Status code](http://www.restapitutorial.com/httpstatuscodes.html). In case a HTTP body is specified the `Response` **keyword** should be followed by a HTTP Body [Media Type (MIME type)](http://en.wikipedia.org/wiki/Internet_media_type).

The Full Response Subsection list syntax is as follows:

	+ Response <Status Code> [(<Media Type>)]

This subsection **must** be listed under a [Method Section](#ResourceMethodSection) unless a HTTP method is specified in the [Resource Section](#ResourceSection)'s header. In that case this subsection must be listed under the [Resource Headers Subsection](#ResourceSection).

This section is a specific type of [Payload](#Payloads) carried by this response. See [Payload Documentation](#Payloads) for details on how to specify the content of this section.

One [Resource Section](#ResourceSection) or [Method Section](#ResourceMethodSection) can contain **one or more different** (that is with different HTTP Status codes) Response Subsections.

Example:

	+ Response 201 (application/json)
		
				{ "message" : "created" }

<a name="ResourceHeadersSection"></a>
#### 4.3.5. Headers Section
**Optional**. Description of HTTP Headers parameters. Content of this subsection is subject to additional formatting.

This section is **recognized** by the `Headers` reserved **keyword** written in a Markdown list. Optionally the `Headers` keyword can be preceded by either the `Response` or `Request` header **keyword**.

The Full Header section list syntax is as follows:

	+ [Request [<identifier>] | Response <status code>] Headers

This subsection must be listed under one of the following sections:

* [Resource Section](#ResourceSection)
* [Method Section](#ResourceMethodSection)

Based on where this section is listed, the headers are expected or sent as follows:

* **Resource Section**: Headers are expected and/or sent with **every** request and/or response on this **Resource's URI**.
* **Method Section**: Headers are expected and/or sent with **every** request and/or response with specific **method and Resource's URI**.

Based on the keywords preceding the `Headers` keyword, the headers are expected or sent as follows:

* `Reques` keyword: Headers are expected only with requests.
* `Response` keyword: Headers are sent only with responses.

The subsection is formatted as a Markdown's [Pre-formatted code blocks](http://daringfireball.net/projects/markdown/syntax#precode) with the following syntax:

	<HTTP header name>: <value>

One HTTP header per line.

This subsection **does not include** any **other sections**.

Example:

	+ Headers
	    
	    	Accept-Charset: utf-8
		    Connection: keep-alive

	+ Request Headers

		    Accept-Charset: utf-8
		    Connection: keep-alive

<a name="ResourceObjectSection"></a>
#### 4.3.6. Object Section
**Optional**. Description of one [resource object manifestation](http://www.w3.org/TR/di-gloss/#def-resource-manifestation). This manifestation should be an archetype resource for this [Resource section](#ResourceSection). This section represents a [Payload](#Payloads).

This section is **recognized** by an object name followed by `Object` recognized **keyword** written in a Markdown list (item). 

The Full list section syntax is as follows:

	+ <object name> Object [(<media type>)]

Object - payload defined in this section can be referred to later by its `<object name>` from any other [Request](#ResourceRequestSection) or [Response](#ResourceResponseSection) payload sections, including those of the following [Resource sections](#ResourceSection).

Refer to MultiMarkdown [cross references](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references) for details on cross referencing. 

Refer to the [Payloads](#Payloads) discussion for a detailed description of this section content. 

Example:

	# My Resource [/resource]
	+ My Resource Object (text/plain)
		
			Hello World
			
	## Retrieve My Resource [GET]
	+ Response 200
		
		[My Resource][]

<a name="ResourceGroups"></a>
### 4.4. Grouping Resources
Resource sections can be grouped together. To group resources simply [nest](#NestedSections) your resource section(s) under a Markdown header starting with the `Group` **keyword**.  

A Group section can contain **further Markdown-formatted content**. If content is provided it is considered to represent the group description.

A Group **should include** at least one [Resource Section](#ResourceSection).

Example:

	# Group Blog Posts
	Resources in this groups are related to **ACME Blog** posts.

	## GET /posts{/id}
		...

	## PUT /posts
		...

	# Group Authors
	## GET /authors
		...

	# Comments
		...

---

<a name="Payloads"></a>
## 5. Payloads
A payload is data expected in a HTTP request or sent in a HTTP response. A Payload consists of meta information in the form of HTTP headers and content received or sent in a HTTP body. Furthermore, an API Blueprint Payload can include its description as well as a discussion of its parameters.

Note that the term "payload" (excluding its description) as used in this document is technically a subset of [HTTP Payload](http://www.w3.org/TR/di-gloss/). There might be some additional metadata (HTTP headers) specified outside of the scope of the payload that can form up the final HTTP Payload.

A Payload **should have** its Media Type associated. A Payload's Media type represents the metadata that is always received or sent in the form of a HTTP `Content-Type` header.

The Payload section header syntax is follows:

	# <payload identifier> [(<media type>)]
	
The Payload subsection header syntax is follows:	

	+ <payload identifier> [(<media type>)]

The Payload is formed by following **optional** subsections: 

* [Headers Subsection](#PayloadHeadersSection)
* [Parameters Subsection](#PayloadParametersSection)
* [Body Subsection](#PayloadBodySection)
* [Schema Subsection](#PayloadSchemaSection)

If **no subsection** is specified, the content of the payload section is considered as a [Body Subsection](#PayloadBodySection).

Example:

	# MyPayload (application/json)
	+ Headers
		
		X-My-Payload-Size: 42

	+ Parameters
		+ message ... A message.

	+ Body
		
			{ ... }

	+ Schema
	
			{ ... }

<a name="PayloadHeadersSection"></a>
### 5.1. Headers Subsection
**Optional**. Specifies the metadata in the form of the HTTP headers to be received or sent with the payload. Content of this section is subject to additional formatting.

This subsection is **recognized** by the `Headers` reserved **keyword** written as a Markdown list item. No further keywords or modifiers are expected.

Refer to [Resource Headers Subsection](#ResourceHeadersSection) for this section's syntax definition.

Example:

	# MyPayload (application/json)
	+ Headers
	
			X-My-Payload-Size: 42

<a name="PayloadParametersSection"></a>
### 5.2. Parameters Subsection
**Optional** for the **application/json** media type. Description of the [Payload](#Payloads)'s parameters. Content of this subsection is subject to additional formatting.

This subsection is **recognized** by the `Parameters` reserved **keyword** written as a Markdown list item.

This subsection can contain **further Markdown-formatted content**. If content is provided, it is considered to represent the general payload parameter's description. The rest of this section is formatted as follows:

	+ <parameter name> [= <default value>] [<type> [,(required | optional)]] ... Markdown-formatted content


Where `<parameter name>` is the name of a [body](#PayloadBodySection) top-level field. To access the elements of an array and to access the fields of a subdocument use [MongoDB Dot Notation](http://docs.mongodb.org/manual/core/document/#dot-notation).

See Resource [Parameters Subsection](#ResourceParametersSection) for further details.

Example:

	# MyPayload (application/json)
	+ Headers
	
			X-My-Payload-Size: 42

	+ Parameters
	
			+ message (string) ... A message from **ACME Blog** API.

<a name="PayloadBodySection"></a>
### 5.3. Body Subsection
**Optional**. Specifies the content of the payload received or sent in the form of a HTTP body.

This subsection is **recognized** by the `Body` reserved **keyword** written as a Markdown list item.

This subsection represents an API Blueprint Document [Asset](#DocumentAssets).

This subsection **does not include** any **other subsections**.

Example:

	# MyPayload (application/json)
	+ Headers
	
			X-My-Payload-Size: 42

	+ Parameters
		+ message (string) ... A message from **ACME Blog** API.

	+ Body
	
			{ "message" : "Hello World." }

<a name="PayloadSchemaSection"></a>
### 5.4. Schema Subsection
**Optional**. Where applicable, specifies a schema used to validate this payload's body content.

This subsection is **recognized** by the `Schema` reserved **keyword** written as a Markdown list item.

This subsection represents an API Blueprint Document [Asset](#DocumentAssets).

This subsection **does not include** any **other sections**.

---

<a name="DocumentAssets"></a>
## 6. Assets
An API Blueprint Document Asset is simply a resource (not to be confused with API Resource) – a piece of data used in [payloads](#Payloads).

<a name="InlineDocumentAsset"></a>
### 6.1. Inline Asset
In its simplest form an asset is essentially a Markdown [Pre-formatted code block](http://daringfireball.net/projects/markdown/syntax#precode). The sole content of this block is considered to represent the Asset's data.

Example:

	# Asset Name
		
		{ "message" : "Hello World." }
		
	-- or --
	
	+ Asset Name

			{ "message" : "Hello World." }

---
