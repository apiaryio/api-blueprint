FORMAT: 1A

# Gist Fox API
Gist Fox API is a **pastes service** similar to [GitHub's Gist][http://gist.github.com].

# Gist Fox API Root [/]
Gist Fox API entry point.

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
A single Gist object.

+ Parameters
    + id (string) ... ID of the gist in the form of a hash.

+ Model (application/hal+json)
    + Headers

            Link: <http:/api.gistfox.com/gists/42>;rel="self", <http:/api.gistfox.com/gists/42/star>;rel="star"

    + Body

            {
                "_links": {
                    "self": { "href": "/gists/42" },
                    "star": { "href": "/gists/42/star" },
                },
                "_embedded": {
                    "files": {
                        "file.txt": {
                            "_links": {
                                "self": { "href": "gists/42/file.txt"}
                            },
                            "size": 932,
                            "filename": "file.txt"
                        }
                    },
                },
                "id": "42",
                "description": "Description of Gist",
                "created_at": "2014-04-14T02:15:15Z"
            }

### Retrieve a Single Gist [GET]
+ Response 200
    
    [Gist][]

### Edit a gist [PATCH]
All files from the previous version of the gist are carried over by default if not included in the hash. Deletes can be performed by including the filename with a null hash.

+ Request (application/json)

        {
            "description": "Description of Gist",
            "files": {
                "file.txt": {
                    "content": "Updated file contents"
                },
                "old_name.txt": {
                    "filename": "new_name.txt",
                    "content": "Modified contents"
                },
                "new_file.txt": {
                    "content": "A new file"
                },
                "delete_this_file.txt": null
            }
        }

+ Response 200
    
    [Gist][]

### Delete a Gist [DELETE]
+ Response 204

## Gists Collection [/gists?{since}]
A collection of all Gists.

+ Model (application/hal+json)
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
                            "description": "Description of Gist",
                            "created_at": "2014-04-14T02:15:15Z"
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
+ Request (application/json)

        {
            "description": "Description of Gist",
            "files": {
                "file.txt": {
                    "content": "String file contents"
                }
            }
        }

+ Response 201 (application/hal+json)

    [Gist][]

## Star [/gists/{id}/star]
+ Parameters

    + id (string) ... ID of the gist in the form of a hash

+ Model (application/hal+json)
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
