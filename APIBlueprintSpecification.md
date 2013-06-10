Author: z@apiary.io

# API Blueprint Language Specification

## Revision 1A

---

## Contents
1. [Introduction][Introduction]
2. [API Blueprint Language][Language]
3. [API Blueprint Document][Document]
	1. [Sections][Sections]
	2. [Reserved Section Names][ReservedSectionNames]
	3. [Nested sections][NestedSections]
	4. [Other Markdown headers][OtherMarkdownHeaders]
	5. [Special Sections][SpecialSections]
4. [API Blueprint Document Structure][DocumentStructure]
	1. [Metadata Section][MetadataSection]
	2. [API Name & Overview Section][APINameOverviewSection]
	3. [Resource Section][ResourceSection]
		1. [Parameters Section][ResourceParametersSection]
		2. [Method Section][ResourceMethodSection]
		3. [Request Section][ResourceRequestSection]
		4. [Response Section][ResourceResponseSection]
		5. [Headers Section][ResourceHeadersSection]
		6. [Object Section][ResourceObjectSection]
	4. [Grouping resources][ResourceGroups]
5. [Payloads][Payloads]
	1. [Headers Subsection][PayloadHeadersSection]
	2. [Parameters Subsection][PayloadParametersSection]
	3. [Body Subsection][PayloadBodySection]
	4. [Schema Subsection][PayloadSchemaSection]
6. [Assets][DocumentAssets]
	1. [Inline Asset][InlineDocumentAsset]

---

## 1. Introduction [Introduction]
This documents is full specification of [API Blueprint](http://apiblueprint.org) Language (hereafter "API Blueprint"). API Blueprint is **Web API documentation language**.

Please consult [API Blueprint homepage](http://apiblueprint.org) for introduction to the API Blueprint.

---

## 2. API Blueprint Language [Language]
API Blueprint Language is a [Markdown](http://daringfireball.net/projects/markdown) with certain constructs used for defining and documenting Web API. It inherits some major [MultiMarkdown](http://fletcherpenney.net/multimarkdown) and [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown) features.

Before you will proceed with this document please make yourself familiar with the basic [Markdown Syntax](http://daringfireball.net/projects/markdown/syntax) as well as with the Metadata and Automatic Cross-References sections of [MultiMarkdown Syntax](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#multimarkdown-syntax-guide) and GitHub Flavored Markdown's [newlines & fenced code blocks](https://help.github.com/articles/github-flavored-markdown).

---

## 3. API Blueprint Document [Document]
API Blueprint Document is a Markdown document where you define and describe a Web API interface.

The document itself is divided into several logical **sections** and thus forming **API Blueprint Document Structure**.

### 3.1. Sections [Sections]
A section represents logical units of your API Blueprint. For example an API overview, group of resources or a resource definition. Some sections might be composed of another, nested, sections. For example a resource definition might contain resource URI parameters description as its subsection.

Sections are recognized by a **reserved section name** or an **URI template** in **Markdown header**. Alternatively some selected sections are recognized by a **reserved section name** in a **Markdown list item** followed by newline.

Each section and subsection has strictly defined name, meaning and its expected content. Anything between a section start and another section start is considered to be a section. This implies you **should avoid** using reserved section names – **keywords** in other Markdown headers.

Each Markdown header lead section can be explicitly terminated by a Markdown horizontal rule. This implies you also **should avoid** deliberately using Markdown horizontal rules.

### 3.2. Reserved Section Names [ReservedSectionNames]
Reserved keywords are:

- Markdown Headers:
	- HTTP methods: **GET, POST, PUT, DELETE, OPTIONS, PATCH, PROPPATCH, LOCK, UNLOCK, COPY, MOVE, MKCOL, HEAD**
	- URI templates (e.g. **/resource/{id}**)
	- Combination of HTTP method and URI Template (e.g. **GET /resource/{id}**)

- Markdown List item: 
	- **Request**
	- **Response**
	- **Headers**
	- **Parameters**
	- **Body**
	- **Schema**

Sections are discussed in [API Blueprint Document Structure](DocumentStructure). Note that some section names can contain variable components such as identifiers or other modifiers. See relevant section's entry to find out more about how section name is built.

### 3.3. Nested sections [NestedSections]
Some sections can or must be nested. To nest a section in another section simply **increase** its **header level** and / or **list item indentation**.

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

What section can be nested depends on the actual section as described in relevant [API Blueprint Document Structure](DocumentStructure) section's entry.

Note that API Blueprint parser should not be strict on proper header levels.

### 3.4. Other Markdown headers [OtherMarkdownHeaders]
You are free to use any Markdown header of your liking anywhere in section description as long as it does not clash with [Reserved Section Names](ReservedSectionNames). It is considered a good practice to keep your own header level nested to your actual section.

### 3.5. Special Sections [SpecialSections]
There are **two additional** sections of a Blueprint Document to sections represented by a [Reserved Name Sections][Sections]: A [Metadata Section][MetadataSection] and the [API Name & Overview][APINameOverviewSection]. These are discussed in the [API Blueprint Document Structure][DocumentStructure]

---

## 4. API Blueprint Document Structure [DocumentStructure]
Bellow you will find description of every section of the API Blueprint Document. Note that all sections are optional. However the document should contain one or more [Resource][ResourceSection] Section.

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

### 4.1. Metadata Section [MetadataSection]
**Optional**. API metadata.

This section is **recognized** as [MultiMarkdown' Metadata](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#metadata). It starts from the beginning of the document and ends with a first Markdown header.

This section **does not include** any **other sections**.

#### Supported Metadata
* **`Host` (or `HOST`)** *(optional)* ... API server hostname.
* **`Format`(or `FORMAT`)** *(optional)* ... API Blueprint version. Leave blank for legacy format. Use `1A` for actual version.

Example:

	HOST: http://blog.acme.com
	FORMAT: 1A

### 4.2. API Name & Overview Section [APINameOverviewSection]
**Optional**. Name of the API in the form of a Markdown header.

This section is **recognized** as the **first** Markdown header in your document its name is considered to be your **API name**.

This section can contain **further Markdown-formatted content**. If a content is provided it is considered to represent the API Overview.

This section **does not include** any **other sections**.

Example:

	# My API Name

	-- or --

	# Basic ACME Blog API
	Welcome to the **ACME Blog** API. This API provides access to the **ACME Blog** service.

### 4.3. Resource Section [ResourceSection]
**Optional**. Definition of exactly **one** API [**resource**](http://www.w3.org/TR/di-gloss/#def-resource) specified by its *URI* **OR** a **set of resources** (a resource cluster) matching its *URI template*.

Your blueprint document can contain multiple sections for the same resource (resource cluster) - URI (URI template), as long as their HTTP methods differs. However it is considered a good practice to group multiple HTTP methods under one resource (resource cluster).

This section is **recognized** by an [RFC 6570 URI template](http://tools.ietf.org/html/rfc6570) written in a Markdown header. Optionally the header can contain **one** leading [HTTP Request Method](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) in which case the rest of this section is considered to represent [Method Section][ResourceMethodSection].

Alternatively this section is **recognized** by a MultiMarkdown header with URI Template specified in its [explicit label](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references).

This section can contain **further Markdown-formatted content**. If a content is provided it is considered to represent Resource description.

If no **HTTP Request Method** is specified, this section **should include** at least one nested [Method Section][ResourceMethodSection].

In addition to any mandatory nested sections this section **may include** following additional subsections:
 
* [Parameters Section][ResourceParametersSection]
* Nested [Method Section][ResourceMethodSection],  if **no** HTTP Request Method is specified
* [Headers Section][ResourceHeadersSection]
* [Object Section][ResourceObjectSection]

Example:

	# PUT /posts

	-- or --

	# GET /posts{/id}

	-- or --

	# /posts
	
	-- or --
	
	# My Resource [/resource]

#### 4.3.1. Parameters Section [ResourceParametersSection]
**Optional**. Description of [Resource Section][ResourceSection]'s URI parameters. Content of this section is subject to additional formatting.

This subsection is **recognized** by the **"Parameters"** reserved **keyword** written as a Markdown list item. If present, it must be subsection of a [Resource Section][ResourceSection].

This subsection can contain **further Markdown-formatted content**. If a content is provided it is considered to represent general Resource URI parameter description. The rest of this subsection is formatted as follows:

	+ <parameter name> [= <default value>] [<type> [,(required | optional)]] ... Markdown-formatted content

Where:

* `<parameter name>` is a parameter name as written in [Resource Section][ResourceSection]'s URI (e.g. "id").
* `<default value>` is **optional** parameter default or example value (e.g. 1234).
* `<type>` is **optional** parameter type as expected by your API (e.g. "number").
* `required` is **optional** specifier of a required parameter
* `optional` is **optional** specifier of a optional parameter

This subsection does not have to list every URI parameter. It **should not** however contain parameter that is not specified in URI.

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

#### 4.3.2. Method Section [ResourceMethodSection]
**Expected** if there is no HTTP method specified in [Resource Section][ResourceSection]'s header. **Illegal** otherwise. [HTTP Request Method](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) available for this Resource.

This section is **recognized** by one of the [HTTP Request Methods](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) written in capitals as an Markdown header.

Alternatively this section is **recognized** by a MultiMarkdown header with HTTP Request Method specified in its [explicit label](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references).

This section can contain **further Markdown-formatted content**. If a content is provided it is considered to represent this Resource method description.

This section **should include** at least one [Response Subsection][ResourceResponseSection]. In addition to mandatory nested section this section **may include** following additional subsections:
 
* [Parameters Section][ResourceParametersSection]
* [Request Section][ResourceRequestSection], if a HTTP Request Method is specified
* [Response Section][ResourceResponseSection], if a HTTP Request Method is specified
* [Headers Section][ResourceHeadersSection]

One [Resource Section][ResourceSection] can contain **one or more different** Method Sections.

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

#### 4.3.3. Request Section [ResourceRequestSection]
**Optional**. Description of exactly *one* [HTTP request](http://www.w3.org/TR/di-gloss/#def-http-request).

This section is **recognized** by the **"Request"** reserved **keyword** written in a Markdown header. The **"Request"** can be followed by an arbitrary string representing user identifier of this request. This identifier **must not** be enclosed in brackets. In case HTTP body is specified the **"Request"** keyword (and possible identifier) **should be** followed by HTTP Body [Media Type (MIME type)](http://en.wikipedia.org/wiki/Internet_media_type).

Full Request Subsection list syntax is as follows:

	+ Request [<identifier>] [(<Media Type>)]

This subsection is a specific type of [Payload][Payloads] carried by this request. See [Payloads Documentation][Payloads] for details on how to specify the content of this section.

One [Resource Section][ResourceSection] or [Method Section][ResourceMethodSection] can contain **one or more different** (that is with different identifier) Request Subsections.

Example:

	+ Request (text/plain)
		
			Hello World

	-- or --

	+ Request Create Blog Post (application/json)
	    
	    	{ "message" : "Hello World." }

#### 4.3.4. Response Section [ResourceResponseSection]
**Expected**. Description of exactly *one* [HTTP response](http://www.w3.org/TR/di-gloss/#def-http-response).

This subsection is **recognized** by the **"Response"** reserved **keyword** written in a Markdown list followed by a [HTTP Status code](http://www.restapitutorial.com/httpstatuscodes.html). In case HTTP body is specified the **"Response"** keyword should be followed by HTTP Body [Media Type (MIME type)](http://en.wikipedia.org/wiki/Internet_media_type).

Full Response Subsection list syntax is as follows:

	+ Response <Status Code> [(<Media Type>)]

This subsection **must** be listed under a [Method Section][ResourceMethodSection] unless a HTTP method is specified in the [Resource Section][ResourceSection]'s header. In that case this subsection must be listed under the [Resource Headers Subsection][ResourceSection].

This section is a specific type of [Payload][Payloads] carried by this response. See [Payload Documentation][Payloads] for details on how to specify the content of this section.

One [Resource Section][ResourceSection] or [Method Section][ResourceMethodSection] can contain **one or more different** (that is with different HTTP Status code) Response Subsections.

Example:

	+ Response 201 (application/json)
		
				{ "message" : "created" }

#### 4.3.5. Headers Section [ResourceHeadersSection]
**Optional**. Description HTTP Headers parameters. Content of this subsection is subject to additional formatting.

This section is **recognized** by the **"Headers"** reserved **keyword** written in a Markdown list. Optionally the **"Headers"** keyword can be preceded by either `Response` or `Request` header keyword.

Full Header section list syntax is as follows:

	+ [Request [<identifier>] | Response <status code>] Headers

This subsection must be listed under one of the following sections:

* [Resource Section][ResourceSection]
* [Method Section][ResourceMethodSection]

Based on where is this sections is listed the headers are expected or send as follows:

* **Resource Section**: Headers are expected and/or send with **every** request and/or response on this **Resource's URI**.
* **Method Section**: Headers are expected and/or send with **every** request and/or response with specific **method and Resource's URI**.

Based on keywords preceding the **"Headers"** keyword the headers are expected or send as follows:

* **Request** keyword: Headers are expected only with requests.
* **Response** keyword: Headers are send only with responses.

The subsection is formatted as an Markdown's [Pre-formatted code blocks](http://daringfireball.net/projects/markdown/syntax#precode) with following syntax:

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

#### 4.3.6. Object Section [ResourceObjectSection]
**Optional**. Description of one [resource object manifestation](http://www.w3.org/TR/di-gloss/#def-resource-manifestation). This manifestation should be an archetype resource for this [Resource section][ResourceSection]. This section represents a [Payload][Payloads].

This section is **recognized** by an object name followed by **Object** recognized **keyword** written in a Markdown list (item). 

Full list section syntax is as follows:

	+ <object name> Object [(<media type>)]

Object - payload defined in this section can be referred later by its `<object name>` from any other [Request][ResourceRequestSection] or [Response][ResourceResponseSection] payload sections, including those of other following [Resource section][ResourceSection].

Refer to MultiMarkdown [cross references](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references) for details on cross referencing. 

Refer to [Payloads][Payloads] discussion for detailed description of this section content. 

Example:

	# My Resource [/resource]
	+ My Resource Object (text/plain)
		
			Hello World
			
	## Retrieve My Resource [GET]
	+ Response 200
		
		[My Resource][]

### 4.4. Grouping resources [ResourceGroups]
Resource sections can be grouped together. For example by a common task such as handling payments, shopping cart manipulation, blog post management or user management.

To group resources simply [nest][NestedSections] your resource section(s) under a Markdown header of a group's name. Note that if group follows immediately after the [API Name & Overview Section][APINameOverviewSection], the [API Name & Overview Section][APINameOverviewSection] must be explicitly terminated by a  Markdown horizontal rule as discussed in [Sections][Sections].

Group section can contain **further Markdown-formatted content**. If a content is provided it is considered to represent group description.

Group **should include** at least one [Resource Section][ResourceSection].

Example:

	# Blog Posts
	Resources in this groups are related to **ACME Blog** posts.

	## GET /posts{/id}
		...

	## PUT /posts
		...

	# Authors
	## GET /authors
		...

	# Comments
		...

---

## 5. Payloads [Payloads]
An payload is data expected in a HTTP request or send in a HTTP response. Payload consists of meta information in form of HTTP headers and content received or send in a HTTP body. Furthermore API Blueprint Payload can include its description as well as discussion of its parameters.

Note that the term "payload" (excluding its description) as used in this document is technically a subset of [HTTP Payload](http://www.w3.org/TR/di-gloss/). There might be additional metadata (HTTP headers) specified outside of the scope of the payload that can form up the final HTTP Payload.

A Payload **should have** its Media Type associated. Payload's Media type represents a metadata that is always received or send in form of an HTTP `Content-Type` header.

Payload section header syntax is follows:

	# <payload identifier> [(<media type>)]
	
Payload subsection header syntax is follows:	

	+ <payload identifier> [(<media type>)]

Payload is formed by following **optional** subsections: 

* [Headers Subsection][PayloadHeadersSection]
* [Parameters Subsection][PayloadParametersSection]
* [Body Subsection][PayloadBodySection]
* [Schema Subsection][PayloadSchemaSection]

If **no subsection** is specified content of the payload section is considered as a [Body Subsection][PayloadBodySection].

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


### 5.1. Headers Subsection [PayloadHeadersSection]
**Optional**. Specifies the metadata in form of HTTP headers to be received or send with the payload. Content of this section is subject to additional formatting.

This subsection is **recognized** by the **"Headers"** reserved **keyword** written as a Markdown list item. No further keywords or modifiers are expected.

Refer to [Resource Headers Subsection][ResourceHeadersSection] for this section's syntax definition.

Example:

	# MyPayload (application/json)
	+ Headers
	
			X-My-Payload-Size: 42

### 5.2. Parameters Subsection [PayloadParametersSection]
**Optional** for **application/json** media type. Description of [Payload][Payloads]'s parameters. Content of this subsection is subject to additional formatting.

This subsection is **recognized** by the **"Parameters"** reserved **keyword** written as a Markdown list item.

This subsection can contain **further Markdown-formatted content**. If a content is provided it is considered to represent general payload parameters description. The rest of this section is formatted as follows:

	+ <parameter name> [= <default value>] [<type> [,(required | optional)]] ... Markdown-formatted content


Where `<parameter name>` is name of a [body][PayloadBodySection] top-level field. To access the elements of an array and to access the fields of a subdocument use [MongoDB Dot Notation](http://docs.mongodb.org/manual/core/document/#dot-notation).

See Resource [Parameters Subsection][ResourceParametersSection] for further details.

Example:

	# MyPayload (application/json)
	+ Headers
	
			X-My-Payload-Size: 42

	+ Parameters
	
			+ message (string) ... A message from **ACME Blog** API.

### 5.3. Body Subsection [PayloadBodySection]
**Optional**. Specifies content of the payload received or send in the form of HTTP body.

This subsection is **recognized** by the **"Body"** reserved **keyword** written as a Markdown list item.

This subsection represents an API Blueprint Document [Asset][DocumentAssets].

This subsection **does not include** any **other subsections**.

Example:

	# MyPayload (application/json)
	+ Headers
	
			X-My-Payload-Size: 42

	+ Parameters
		+ message (string) ... A message from **ACME Blog** API.

	+ Body
	
			{ "message" : "Hello World." }

### 5.4. Schema Subsection [PayloadSchemaSection]
**Optional**. Where applicable, specifies a schema used to validate this payload's body content.

This subsection is **recognized** by the **"Schema"** reserved **keyword** written as a Markdown list item.

This subsection represents an API Blueprint Document [Asset][DocumentAssets].

This subsection **does not include** any **other sections**.

---

## 6. Assets [DocumentAssets]
An API Blueprint Document Asset is simply a resource (not to be confused with API Resource) – a piece data used in [payloads][Payloads].

### 6.1. Inline Asset [InlineDocumentAsset]
In its simplest form an asset is essentially a Markdown's [Pre-formatted code blocks](http://daringfireball.net/projects/markdown/syntax#precode). The sole content of this block is considered to represent the Asset's data.

Example:

	# Asset Name
		
		{ "message" : "Hello World." }
		
	-- or --
	
	+ Asset Name

			{ "message" : "Hello World." }

---