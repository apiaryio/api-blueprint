FORMAT: 1A

# Gist Fox API
Gist Fox API is a **pastes service** similar to [GitHub's Gist](http://gist.github.com).

## Authentication
Currently the Gist Fox API does not provide authenticated access.

## Media Types
Where applicable this API uses the [HAL+JSON](https://github.com/mikekelly/hal_specification/blob/master/hal_specification.md) media-type to represent resources states and affordances.

Requests with a message-body are using plain JSON to set or update resource states.

## Error States
The common [HTTP Response Status Codes](https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md) are used.

# Gist Fox API Root [/]
Gist Fox API entry point.

This resource does not have any attributes. Instead it offers the initial API affordances in the form of the HTTP Link header and 
HAL links.

## Retrieve the Entry Point [GET]

+ Response 200 (application/hal+json)
    + Headers
    
            Link: <http:/api.gistfox.com/>;rel="self",<http:/api.gistfox.com/gists>;rel="gists"

    + Body

            {
                "_links": {
                    "self": { "href": "/" },
                    "gists": { "href": "/gists?{since}", "templated": true }
                }
            }

# Group Gist
Gist-related resources of *Gist Fox API*.

## Gist [/gists/{id}]
A single Gist object. The Gist resource is the central resource in the Gist Fox API. It represents one paste - a single text note.

The Gist resource has the following attributes: 

- id
- created_at
- description
- content

The states *id* and *created_at* are assigned by the Gist Fox API at the moment of creation. 


+ Parameters
    + id (string) ... ID of the Gist in the form of a hash.

+ Model (application/hal+json)

    HAL+JSON representation of Gist Resource. In addition to representing its state in the JSON form it offers affordances in the form of the HTTP Link header and HAL links.

    + Headers

            Link: <http:/api.gistfox.com/gists/42>;rel="self", <http:/api.gistfox.com/gists/42/star>;rel="star"

    + Body

            {
                "_links": {
                    "self": { "href": "/gists/42" },
                    "star": { "href": "/gists/42/star" },
                },
                "id": "42",
                "created_at": "2014-04-14T02:15:15Z",
                "description": "Description of Gist",
                "content": "String contents"
            }

### Retrieve a Single Gist [GET]
+ Response 200
    
    [Gist][]

### Edit a gist [PATCH]
To update a Gist send a JSON with updated value for one or more of the Gist resource attributes. All attributes values (states) from the previous version of this Gist are carried over by default if not included in the hash.

+ Request (application/json)

        {
            "content": "Updated file contents"
        }

+ Response 200
    
    [Gist][]

### Delete a Gist [DELETE]
+ Response 204

## Gists Collection [/gists?{since}]
Collection of all Gists.

The Star resource has the following attribute:

- total

In addition it **embeds** all *Gist Resource* in the Gist Fox API.


+ Model (application/hal+json)

    HAL+JSON representation of Gist Collection Resource. The Gist resources in collections are embedded. Note the embedded Gists resource are incomplete representations of the Gist in question. Use the respective Gist link to retrieve its full representation.

    + Headers

            Link: <http:/api.gistfox.com/gists>;rel="self"

    + Body

            {
                "_links": {
                    "self": { "href": "/gists" }
                },
                "_embedded": {
                    "gists": [
                        {
                            "_links" : {
                                "self": { "href": "/gists/42" }
                            },
                            "id": "42",
                            "created_at": "2014-04-14T02:15:15Z",
                            "description": "Description of Gist"
                        }
                    ]
                },
                "total": 1
            }

### List All Gists [GET]
+ Parameters
    + since (optional, string) ... Timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ Only gists updated at or after this time are returned.

+ Response 200

    [Gists Collection][]

### Create a Gist [POST]
To create a new Gist simply provide a JSON hash of the *description* and *content* attributes for the new Gist. 

+ Request (application/json)

        {
            "description": "Description of Gist",
            "content": "String content"
        }

+ Response 201 (application/hal+json)

    [Gist][]

## Star [/gists/{id}/star]
Star resource represents a Gist starred status. 

The Star resource has the following attribute:

- starred


+ Parameters

    + id (string) ... ID of the gist in the form of a hash

+ Model (application/hal+json)

    HAL+JSON representation of Star Resource.

    + Headers

            Link: <http:/api.gistfox.com/gists/42/star>;rel="self"

    + Body

            {
                "_links": {
                    "self": { "href": "/gists/42/star" },
                },
                "starred": true
            }

### Star a Gist [PUT]
+ Response 204

### Unstar a Gist [DELETE]
+ Response 204

### Check if a Gist is Starred [GET]
+ Response 200

    [Star][]
