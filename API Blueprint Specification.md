Author: z@apiary.io

# API Blueprint Language Specification

---

### Format 1A

---

## Contents
1. [Introduction](#Introduction)
2. [API Blueprint Language](#Language)
3. [API Blueprint Document](#Document)
	1. [Sections](#Sections)
	2. [Reserved Section Names](#ReservedSectionNames)
	3. [Nested sections](#NestedSections)
	4. [Other Markdown headers](#OtherMarkdownHeaders)
	5. [Sections without keyword](#SpecialSections)
	6. [Identifiers](#Identifiers)
4. [API Blueprint Document Structure](#DocumentStructure)
	1. [Metadata Section](#MetadataSection)
	2. [API Name & Overview Section](#APINameOverviewSection)
	3. [Resource Group Section](#ResourceGroups)	
		1. [Resource Section](#ResourceSection)
			1. [Resource Parameters Section](#ResourceParametersSection)
			2. [Resource Headers Section](#ResourceHeadersSection)
			3. [Resource Object Section](#ResourceObjectSection)
			4. [Resource Action Section](#ResourceActionSection)
				1. [Action Parameters Section](#ActionParametersSection)
				2. [Action Headers Section](#ActionHeadersSection)
				3. [Action Request Section](#ActionRequestSection)
				4. [Action Response Section](#ActionResponseSection)
5. [Payload Structure](#Payload)
	1. [Payload Headers Section](#PayloadHeadersSection)
	2. [Payload Parameters Section](#PayloadParametersSection)
	3. [Payload Body Section](#PayloadBodySection)
	4. [Payload Schema Section](#PayloadSchemaSection)
6. [Assets](#DocumentAssets)
	1. [Inline Asset](#InlineDocumentAsset)

---

[Glossary of Terms](https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md)

---

<a name="Introduction"></a>
## 1. Introduction
This document is a full specification of the [API Blueprint](http://apiblueprint.org) Language (hereafter "API Blueprint"). API Blueprint is a **Web API documentation language**.

Please refer to the [API Blueprint homepage](http://apiblueprint.org) for an introduction to API Blueprint.

<a name="Language"></a>
## 2. API Blueprint
API Blueprint is essentially a set of semantical assumption on top of a [Markdown](http://daringfireball.net/projects/markdown) syntax that are used to define a Web API. 

In additional to regular Markdown syntax API Blueprint inherits some [MultiMarkdown](http://fletcherpenney.net/multimarkdown) and [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown) features.

Before you proceed with this document please make yourself familiar with the basic [Markdown Syntax](http://daringfireball.net/projects/markdown/syntax) as well as with the Metadata and Cross-References sections of [MultiMarkdown Syntax](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#multimarkdown-syntax-guide) and GitHub Flavored Markdown's [newlines & fenced code blocks](https://help.github.com/articles/github-flavored-markdown).

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
	- `Group`

- Markdown List items: 
	- `Request`
	- `Response`
	- `Header` & `Headers`
	- `Parameter` & `Parameters`
	- `Body`
	- `Schema`
	- `Object`

**NOTE:** With the exception of HTTP methods keywords the section keywords are **case insensitive**.

Sections are discussed in [API Blueprint Document Structure](#DocumentStructure). Note that some section names might contain variable components such as [identifiers](#Identifiers) or other modifiers. See the relevant section's entry to find out more about how its section name is built.

<a name="NestedSections"></a>
### 3.3. Nested Sections
Some sections might be nested under another section. To nest a section simply **increase** its **header level** and / or **list item indentation**.

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
It is possible to use any other Markdown header in a section description as long as it does not clash with the [Reserved Section Names](#ReservedSectionNames). It is considered good practice to keep your header level nested to your actual section.

<a name="SpecialSections"></a>
### 3.5. Sections without keyword
There are **two additional** sections of an API Blueprint Document that are not recognized by a keyword: The [Metadata Section](#MetadataSection) and the [API Name & Overview Section](#APINameOverviewSection). These sections are discussed in detail in the [API Blueprint Document Structure](#DocumentStructure).

<a name="Identifiers"></a>
### 3.6. Identifiers 
Several sections names might include an identifier. An identifier is any **non-empty combination** of a **alphanumerical character**, **underscore**, **dash**  and a **space** unless stated otherwise. **No other characters** (e.g. punctation or other whitespace characters) **are allowed**. 

<a name="DocumentStructure"></a>
## 4. API Blueprint Document Structure
Bellow you will find a description of each section of the API Blueprint Document. Note that all sections are, by default, optional. However, the document should contain at least one [Resource](#ResourceSection) Section.

Full API Blueprint Document layout:

	+ Metadata
	|
	+ API Name & Overview Section
	| 
	+ Resource Group Section
	|	|
	|	+ Resource Section 
	|	|	|
	|	|	+ Parameters Section 
	|	|	|
	|	|	+ Headers Sections
	|	|	|
	|	|	+ Resource Object Section
	|	|	|	|
	|	|	|	...
	|	|	|
	|	|	+ Action Section
	|	|	|	|
	|	|	|	+ Parameters Section 
	|	|	|	|
	|	|	|	+ Headers Sections				
	|	|	|	|
	|	|	|	+ Request Section
	|	|	|	|	|
	|	|	|	|	+ Parameters Section
	|	|	|	|	|
	|	|	|	|	+ Headers Section
	|	|	|	|	|
	|	|	|	|	+ Body Section
	|	|	|	|	|
	|	|	|	|	+ Schema Section
	|	|	|	|
	|	|	|	+ Response Section
	|	|	|		|
	|	|	|		+ Parameters Section
	|	|	|		|
	|	|	|		+ Headers Section
	|	|	|		|
	|	|	|		+ Body Section
	|	|	|		|
	|	|	|		+ Schema Section					
	|	|	|
	|	|	+ Action Section
	|	|	|	|
	|	|	|	...
	|	|	...
	|	|
	|	+ Resource Section 
	|	|	|
	|	|	... 
	|	...
	|
	+ Resource Group Section
	|	|
	|	...
	...


Layout of a resource section without a parent group:

	+ Metadata
	|
	+ API Name & Overview Section
	|
	...
	| 
	+ Resource Section 
	|	|
	|	...	
	...


<a name="MetadataSection"></a>
### 4.1. Metadata Section
**Optional**. API metadata.

This section is **recognized** as [MultiMarkdown Metadata](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#metadata). It starts at the beginning of the document and ends with the first Markdown element that is not recognized as MutliMarkdown Metadata.

This section **does not include** any **other sections**.

Metadata keys and its values are tool-specific. Please refer to relevant tool documentation for the list of supported keys.

Example:

	HOST: http://blog.acme.com
	FORMAT: 1A

<a name="APINameOverviewSection"></a>
### 4.2. API Name & Overview Section
**Optional**. Name of the API in the form of a Markdown header.

This section is **recognized** as the **first** Markdown header in your document. Its content is considered to be your **API name**.

This section can contain **further Markdown-formatted content**. If content is provided it is considered to represent the API overview / description. 

This section **does not include** any **other sections**.

Example:

	# My API Name

	-- or --

	# Basic ACME Blog API
	Welcome to the **ACME Blog** API. This API provides access to the **ACME Blog** service.

<a name="ResourceGroups"></a>
### 4.3. Resource Group Section
**Optional**. This sections represents a group of resources - [Resource Sections](#ResourceSection).

This section is **recognized** by the `Group` **keyword** followed by a name of group in the form of a [identifier](#Identifiers). The syntax is as follows:

	# Group <identifier>

A Group section may contain **further Markdown-formatted content**. If a content is provided it is considered to represent the group description.

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

<a name="ResourceSection"></a>
### 4.3.1 Resource Section
**Optional**. Definition of exactly **one** API [**resource**](http://www.w3.org/TR/di-gloss/#def-resource) specified by its *URI* **OR** a **set of resources** (a resource template) matching its *URI template*.

Your Blueprint document can contain multiple sections for the same resource (or resource set), as long as their HTTP methods differ. However it is considered good practice to group multiple HTTP methods under one resource (resource set).

This section is **recognized** by an [RFC 6570 URI template](http://tools.ietf.org/html/rfc6570) written in a Markdown header. Optionally the header can contain **one** leading [HTTP Request Method](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) in which case **the rest of this section** is considered to **represent the [Action Section](#ResourceActionSection).**

Alternatively this section is **recognized** by a MultiMarkdown header with URI Template specified in its [explicit label](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references).

This section might be a top level section or nested under a [Resource Group Section](#ResourceGroups).

This section may contain **further Markdown-formatted content**. If a content is provided it is considered to represent the Resource description.

If no **HTTP Request Method** is specified, this section **should include** at least one nested [Action Section](#ResourceActionSection).

In addition to any mandatory nested sections this section **may include** the following additional subsections:
 
* [Parameters Section](#ResourceParametersSection)
* [Headers Section](#ResourceHeadersSection)
* [Object Section](#ResourceObjectSection)
* [Action Section](#ResourceActionSection),  if **no** HTTP Request Method is specified

Example:

	# PUT /posts

	-- or --

	# GET /posts{/id}

	-- or --

	# /posts
	
	-- or --
	
	# My Resource [/resource]

<a name="ResourceParametersSection"></a>
#### 4.3.1.1. Resource Parameters Section
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


<a name="ResourceHeadersSection"></a>
#### 4.3.1.2 Resource Headers Section
**Optional**. Specifies the message-headers of every transaction on this resource.

Refer to [Payload Headers Subsection](#PayloadHeadersSection) for this section's syntax definition.

<a name="ResourceObjectSection"></a>
#### 4.3.1.3 Resource Object Section
**Optional**. A [resource manifestation](http://www.w3.org/TR/di-gloss/#def-resource-manifestation). One particular representation of this [Resource section](#ResourceSection)' resource. This section represents a [Payload](#Payload).

This section is **recognized** by an object name followed by `Object` recognized **keyword** written in a Markdown list (item). 

The Full list section syntax is as follows:

	+ <object name> Object [(<media type>)]

Object - payload defined in this section can be referred to later by its `<object name>` from any other [Request](#ActionRequestSection) or [Response](#ActionResponseSection) payload sections, including those of the following [Resource sections](#ResourceSection).

Refer to MultiMarkdown [cross references](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references) for details on cross referencing. 

Refer to the [Payloads](#Payload) discussion for a detailed description of this section content. 

Example:

	# My Resource [/resource]
	+ My Resource Object (text/plain)
		
			Hello World
			
	## Retrieve My Resource [GET]
	+ Response 200
		
		[My Resource][]

<a name="ResourceActionSection"></a>
#### 4.3.1.4 Resource Action Section
**Expected** if there is no HTTP method specified in the parent [Resource Section](#ResourceSection)'s header. **Illegal** otherwise. 

This section represents an action to be performed on the parent resource. It defines at least one complete HTTP transaction.

This section is **recognized** by one of the [HTTP Request Methods](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) written in capitals as a Markdown header.

Alternatively this section is **recognized** by a MultiMarkdown header with a HTTP Request Method specified in its [explicit label](https://github.com/fletcher/MultiMarkdown/blob/master/Documentation/MultiMarkdown%20User%27s%20Guide.md#automatic-cross-references).

This section can contain **further Markdown-formatted content**. If a content is provided it is considered to represent this action's description.

This section **should include** at least one [Response Subsection](#ActionResponseSection). In addition this section **may include** the following additional subsections:
 
* [Parameters Section](#ResourceParametersSection)
* [Request Section](#ActionRequestSection)
* [Response Section](#ActionResponseSection)
* [Headers Section](#ResourceHeadersSection)

One [Resource Section](#ResourceSection) can contain **one or more different** Action Sections.

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

<a name="ActionParametersSection"></a>
#### 4.3.1.4.1. Action Parameters Section
**Optional**. Description of **URI parameters** specific to this action.

Refer to [Resource Parameters Section](#ResourceParametersSection) for this section's syntax definition.

<a name="ActionHeadersSection"></a>
#### 4.3.1.4.2. Action Headers Section
**Optional**. Specifies the message-headers of every transaction within this action's context.

Refer to [Payload Headers Subsection](#PayloadHeadersSection) for this section's syntax definition.

<a name="ActionRequestSection"></a>
#### 4.3.1.4.3. Action Request Section
**Optional**. Description of exactly *one* [HTTP request](http://www.w3.org/TR/di-gloss/#def-http-request).

This section is **recognized** by the `Request` reserved **keyword** written in a Markdown header. The `Request` keyword may be followed by an [identifier](#Identifiers) of this request. In the case an HTTP body is specified the `Request` keyword (and possible identifier) might be followed by a HTTP Body [Media Type (MIME type)](http://en.wikipedia.org/wiki/Internet_media_type) enclosed in brackets.

The Full Request Subsection list syntax is as follows:

	+ Request [<identifier>] [(<Media Type>)]

This subsection **must** be nested under an [Action Section](#ResourceActionSection).

This subsection is a specific type of [Payload](#Payload) carried by this request. See [Payloads Documentation](#Payload) for details about how to specify the content of this section.

One [Resource Section](#ResourceSection) or [Action Section](#ResourceActionSection) can contain **one or more different** (that is with a different identifier) Request Subsections.

Example:

	+ Request (text/plain)
		
			Hello World

	-- or --

	+ Request Create Blog Post (application/json)
	    
	    	{ "message" : "Hello World." }

<a name="ActionResponseSection"></a>
#### 4.3.1.4.4. Action Response Section
**Expected**. Description of exactly *one* [HTTP response](http://www.w3.org/TR/di-gloss/#def-http-response).

This subsection is **recognized** by the `Response` reserved **keyword** written in a Markdown list followed by a [HTTP Status code](http://www.restapitutorial.com/httpstatuscodes.html). In the case a HTTP body is specified the `Response` keyword might be followed by a HTTP Body [Media Type (MIME type)](http://en.wikipedia.org/wiki/Internet_media_type) enclosed in brackets.

The Full Response Subsection list syntax is as follows:

	+ Response <Status Code> [(<Media Type>)]

This subsection **must** be nested under an [Action Section](#ResourceActionSection).

This section is a specific type of [Payload](#Payloads) carried by this response. See [Payload Documentation](#Payloads) for details on how to specify the content of this section.

One [Action Section](#ResourceActionSection) can contain **one or more different** (that is with different HTTP Status codes) Response Subsections.

Example:

	+ Response 201 (application/json)
		
				{ "message" : "created" }


<a name="Payload"></a>
## 5. Payload Structure
Payload sections represent the information transferred as payloads of an HTTP request or response messages. A Payload consists of meta information in the form of HTTP headers and content in the form HTTP body. Furthermore, an API Blueprint Payload might include a description, discussion of its message-body parameters and a validation schema.

A Payload **should have** its Media Type associated. A Payload's Media type represents the metadata always received or sent in the form of a HTTP `Content-Type` header.

Following section are payload sections: [Request Section](#ActionRequestSection), [Response Section](#ActionResponseSection) and [Object Section](#ResourceObjectSection).  Refer to the specific payload sections on how to define a payload of the specific type. 

The Payload might include following **optional** subsections: 

* [Headers Subsection](#PayloadHeadersSection)
* [Parameters Subsection](#PayloadParametersSection)
* [Body Subsection](#PayloadBodySection)
* [Schema Subsection](#PayloadSchemaSection)

Example:

	+ Request (application/json)

		Any Markdown formatted *discussion* might be here.

		+ Headers
			
				X-My-Payload-Size: 42

		+ Parameters
			+ message ... A message.

		+ Body
			
				{ ... }

		+ Schema
		
				{ ... }
			
			
**If no subsection is specified the content of the payload section is considered to represent the [Body Subsection](#PayloadBodySection).**
			
Example:

	+ Request (application/json)
			
			{ ... }

<a name="PayloadHeadersSection"></a>
### 5.1. Payload Headers Section
**Optional**. Specifies the message-headers of a Payload section. The content of this section is subject to additional formatting.

This section is **recognized** by the `Headers` reserved **keyword** written in a Markdown list as follows:

	+ Headers

The subsection is formatted as a Markdown's [Pre-formatted code blocks](http://daringfireball.net/projects/markdown/syntax#precode) with the following syntax:

	<HTTP header name>: <value>

One HTTP header per line.

This subsection **does not include** any **other sections**.

Example:

	+ Request (application/json)
		+ Headers
	
	    		Accept-Charset: utf-8
		    	Connection: keep-alive
		    	Content-Type: multipart/form-data, boundary=AaB03x

<a name="PayloadParametersSection"></a>
### 5.2. Payload Parameters Section
**Optional** for the **application/json** media type. Description of the [Payload](#Payload)'s parameters. Content of this subsection is subject to additional formatting.

This subsection is **recognized** by the `Parameters` reserved **keyword** written as a Markdown list item.

This subsection can contain **further Markdown-formatted content**. If content is provided, it is considered to represent the general payload parameter's description. The rest of this section is formatted as follows:

	+ <parameter name> [= <default value>] [<type> [,(required | optional)]] ... Markdown-formatted content


Where `<parameter name>` is the name of a [body](#PayloadBodySection) top-level field. To access the elements of an array and to access the fields of a subdocument use [MongoDB Dot Notation](http://docs.mongodb.org/manual/core/document/#dot-notation).

See Resource [Parameters Subsection](#ResourceParametersSection) for further details.

Example:

	+ Request (application/json)
		+ Headers
	
				X-My-Payload-Size: 42

		+ Parameters
	
				+ message (string) ... A message from **ACME Blog** API.

<a name="PayloadBodySection"></a>
### 5.3. Payload Body Section
**Optional**. Specifies the message-body of a Payload section. Usually a [manifestation of a resource](http://www.w3.org/TR/di-gloss/#def-resource-manifestation).

This subsection is **recognized** by the `Body` reserved **keyword** written as a Markdown list item.

This subsection represents an API Blueprint Document [Asset](#DocumentAssets).

This subsection **does not include** any **other subsections**.

Example:

	+ Request (application/json)
		+ Headers
	
				X-My-Payload-Size: 42

		+ Parameters
			+ message (string) ... A message from **ACME Blog** API.

		+ Body
	
				{ "message" : "Hello World." }

<a name="PayloadSchemaSection"></a>
### 5.4. Payload Schema Section
**Optional**. Where applicable, specifies a schema used to validate this Payload's [Body Section](PayloadBodySection) content.

This subsection is **recognized** by the `Schema` reserved **keyword** written as a Markdown list item.

This subsection represents an API Blueprint Document [Asset](#DocumentAssets).

This subsection **does not include** any **other sections**.

<a name="DocumentAssets"></a>
## 6. Assets
An API Blueprint Document Asset is simply a resource (not to be confused with API Resource) – an atomic data used in [payloads](#Payload).

<a name="InlineDocumentAsset"></a>
### 6.1. Inline Asset
In its simplest form an asset is essentially a Markdown [Pre-formatted code block](http://daringfireball.net/projects/markdown/syntax#precode). The sole content of this block is considered to represent the Asset's data.

Example:

	# Asset Name
		
		{ "message" : "Hello World." }
		
	-- or --
	
	+ Asset Name

			{ "message" : "Hello World." }

