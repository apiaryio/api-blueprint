# API Blueprint Glossary of Terms

A brief list of terms as used in the [API Blueprint](http://apiblueprint.org) context.

## Glossary

<a name="def-action"></a>
### Action
One or more [**HTTP Transactions**](#def-transaction) within a [Resource](#def-resource) with a common [HTTP Request Method](#def-method).

[Requests](#def-request) and [Responses](#def-response) within an Action are ordered into implicit groups where each such group represents one [**HTTP Transaction Example**](#def-transaction-example).

<a name="def-api"></a>
### API
An **HTTP Application programming interface**. Might refer to an API description. See [**API Blueprint**](#def-api-blueprint).

<a name="def-api-blueprint"></a>
### API Blueprint
The **API Blueprint language**. A format used to describe API in an API blueprint file.

<a name="def-asset"></a>
### Asset
**Atomic data**. Most often representing one resource representation in the form of message-body or its validation schema.

<a name="def-attribute"></a>
### Attribute
Based on the context, attribute (property) of a message-body data structure, or attribute of a resource, or an input attribute of a transition – [Action](#def-action).

<a name="def-blueprint"></a>
### Blueprint
An **API description**. A **blueprint file** (or a set of files) that describes an API using the API Blueprint language.

<a name="def-data-structure"></a>
### Data Structure
A particular data organization, or a description of it. In API Blueprint, data structures and its [Attributes](#def-attribute) are described using the Markdown Syntax for Object Notation – [MSON][].

<a name="def-entity"></a>
### Entity
[**Entity**](http://www.w3.org/Protocols/rfc2616/rfc2616-sec7.html) being transferred in a [payload](#def-payload).

<a name="def-header"></a>
### Header
A [**message-header**](#def-message-header).

<a name="def-method"></a>
### Method
An [**HTTP Request Method**](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods).

<a name="def-message"></a>
### Message
An **HTTP Transaction Message**.

<a name="def-message-body"></a>
### Message body
An [**asset**](#def-asset) representing [**HTTP transaction message body**](http://en.wikipedia.org/wiki/HTTP_body_data).

<a name="def-message-header"></a>
### Message header
An [**asset**](#def-asset) representing [**HTTP transaction message header**](http://en.wikipedia.org/wiki/List_of_HTTP_header_fields).
<a name="def-parameter"></a>
### Parameter
An [**URI template**](#def-uri-template) **variable**.

<a name="def-payload"></a>
### Payload
An **HTTP transaction message** including its **discussion** and any additional [**assets**](#def-asset) such as entity-body validation schema.

A payload may have its **identifier** – a string for a [request](#def-request) payload or an [HTTP status code](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes) for a [response](#def-response) payload.

<a name="def-property"></a>
### Property
An [entity](#def-entity) field (attribute).

<a name="def-request"></a>
### Request
A [**payload**](#def-payload) containing one specific [HTTP Request](http://www.w3.org/TR/di-gloss/#def-http-request).

<a name="def-response"></a>
### Response
A [**payload**](#def-payload) containing one specific [HTTP Response](http://www.w3.org/TR/di-gloss/#def-http-response).

<a name="def-resource"></a>
### Resource
An API [**resource**](http://www.w3.org/TR/di-gloss/#def-resource) specified by its *URI*. It can also refer to a [**set of resources**](#def-resource) matching one [**URI template**](#def-uri-template).

<a name="def-resource-group"></a>
### Resource Group
An arbitrary grouping of one or more [**Resource Sets**](#def-resource-set).

<a name="def-resource-model"></a>
### Resource Model
One [**manifestation of a resource**](http://www.w3.org/TR/di-gloss/#def-resource-manifestation) in the form of a [payload](#def-payload). A resource model is an example representation of its resource. Can be referenced later in the place of a [payload](#def-payload).

<a name="def-resource-set"></a>
### Resource Set
A set of all [**resources**](http://www.w3.org/TR/di-gloss/#def-resource) with URIs matching one specific [**URI template**](#def-uri-template).

<a name="def-trait"></a>
### Trait
A quality or characteristic of an API Blueprint SECTION.

<a name="def-transaction"></a>
### Transaction
[HTTP Request](#def-request) with a corresponding [HTTP Response](#def-response).

<a name="def-transaction-example"></a>
### Transaction Example
An implicit group of one or more [Requests](#def-request) and one or more corresponding [Responses](#def-response). If expanded into Request-Response pairs, it represents one or more [**HTTP Transactions**](#def-transaction).

<a name="def-schema"></a>
### Schema
A **validation schema** in a form of an [**asset**](#def-asset) used to validate (or describe) a [**message-body**](#def-message-body).

<a name="def-uri-template"></a>
### URI template
A compact sequence of characters for describing a range of **Uniform Resource Identifiers** through **variable** expansion, see [**RFC 6570**](http://tools.ietf.org/html/rfc6570).

## Additional resources

+ [HTTP/1.1 Terminology](http://www.w3.org/Protocols/rfc2616/rfc2616-sec1.html#sec1.3)
+ [W3C Glossary of Terms for Device Independence](http://www.w3.org/TR/di-gloss)
+ [Know your HTTP well](https://github.com/for-GET/know-your-http-well)
+ [Markdown Syntax for Object Notation][MSON]



[MSON]: https://github.com/apiaryio/mson
