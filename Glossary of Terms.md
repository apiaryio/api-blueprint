# API Blueprint Glossary of Terms

---

A brief list of terms as used in the [API Blueprint](http://apiblueprint.org) context.

---

## Action
A **HTTP transaction** (request-response transaction).

## API
A **HTTP Application programming interface**. Might refer to an API description. See [API Blueprint][].

## API Blueprint
The **API Blueprint language**. A format used to describe API in an API blueprint file.

## Asset
**Atomic data**. Most often representing one resource representation in the form of message-body or its validation schema.

## blueprint
An **API description**. A **blueprint file** (or a set of files) that describes an API using the API Blueprint language.

## Header
A [**message-header**][Message header].

## Method
An [**HTTP Request Method**](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods).

## Message
An **HTTP transaction message**.

## Message header
An asset representing [**HTTP transaction message header**](http://en.wikipedia.org/wiki/List_of_HTTP_header_fields). 

## Message body
An asset representing [**HTTP transaction message body**](http://en.wikipedia.org/wiki/HTTP_body_data). 

## Parameter
An [**URI template**][] **variable**. Also a **message-body key** (field/object) where applicable. 

## Payload
A **HTTP message** as well as its **discussion**,  **parameters description** and any **additional** related **assets** such as a validation schema.

## Request
A [**payload**][Payload] containing one specific [HTTP Request](http://www.w3.org/TR/di-gloss/#def-http-request).

## Response
A [**payload**][Payload] containing one specific [HTTP Response](http://www.w3.org/TR/di-gloss/#def-http-response).

## Resource
An API [**resource**](http://www.w3.org/TR/di-gloss/#def-resource) specified by its *URI*. It can also refer to a [**set of resources**][Resource Set] matching one [**URI template**][].

## Resource Set
A set of API [**resources**](http://www.w3.org/TR/di-gloss/#def-resource) its *URI* matches one specific **URI template**.

## Schema
A **validation schema** in a form of an [**asset**][Asset] used to validate (or describe) a [**message-body**][Message body].

## URI template
A compact sequence of characters for describing a range of **Uniform Resource Identifiers** through **variable** expansion, see [**RFC 6570**](http://tools.ietf.org/html/rfc6570).