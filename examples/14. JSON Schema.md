FORMAT: 1A

# JSON Schema
Every request and response can have a schema. Below you will find examples
using [JSON Schema](http://json-schema.org/) to describe the format of request
and response body content.

## API Blueprint
+ [Previous: Named Endpoints](13.%20Named%20Endpoints.md)
+ [This: Raw API Blueprint](https://raw.github.com/apiaryio/api-blueprint/master/examples/14.%20JSON%20Schema.md)
+ [Next: Advanced JSON Schema](15.%20Advanced%20JSON%20Schema.md)

# Notes [/notes/{id}]

+ Parameters

    + id: abc123 (required) - Unique identifier for a note

## Get a note [GET]
Gets a single note by its unique identifier.

+ Response 200 (application/json)

    + Body

            {
                "id": "abc123",
                "title": "This is a note",
                "content": "This is the note content."
                "tags": [
                    "todo",
                    "home"
                ]
            }

    + Schema

            {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "string"
                    },
                    "title": {
                        "type": "string"
                    },
                    "content": {
                        "type": "string"
                    },
                    "tags": {
                        "type": "array",
                        "items": {
                            "type": "string"
                        }
                    }
                }
            }

## Update a note [PATCH]
Modify a note's data using its unique identifier. You can edit the `title`,
`content`, and `tags`.

+ Request (application/json)

    + Body

            {
                "title": "This is another note",
                "tags": [
                    "todo",
                    "work"
                ]
            }

    + Schema

            {
                "type": "object",
                "properties": {
                    "title": {
                        "type": "string"
                    },
                    "content": {
                        "type": "string"
                    },
                    "tags": {
                        "type": "array",
                        "items": {
                            "type": "string"
                        }
                    }
                },
                "additionalProperties": false
            }

+ Response 204
