# Advanced API Blueprint Tutorial

Welcome to the advanced API Blueprint tutorial! This tutorial will take you through advanced topics like JSON Schema, request and response attributes, data structures and relation types.

This tutorial assumes that you have read the [API Blueprint Tutorial](https://github.com/apiaryio/api-blueprint/blob/master/Tutorial.md).

## JSON Schema

Action request and response bodies can have associated schemas that describe the allowed structure of the body content. JSON bodies are typically described with [JSON Schema](http://json-schema.org/). Given a simple JSON response body we can describe the structure of the response with JSON Schema in a `+ Schema` section.

The schema can describe the type of each member, which members are required, default values, and support a number of other advanced features. Below is an example, taken from the [Polls API](https://raw.github.com/apiaryio/api-blueprint/master/examples/Polls%20API.md) blueprint:

```apib
### Create a New Question [POST]
You may create your own question using this action. It takes a JSON object containing a question and a collection of answers in the form of choices.

+ Request (application/json)

    + Body

            {
              "question": "Favourite language?"
              "choices": [
                "Swift",
                "Objective-C"
              ]
            }

    + Schema

            {
              "$schema": "http://json-schema.org/draft-04/schema#",
              "type": "object",
              "properties": {
                "question": {
                  "type": "string
                },
                "choices": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "minItems": 2
                }
              }
            }
```

## Attributes

Another way of describing examples and the structure of your request and response content is by using [MSON](https://github.com/apiaryio/mson#readme). MSON, like API Blueprint, allows you to use human-readable plain text to describe things rather than formats designed for computer parsing like JSON or YAML. Where API Blueprint allows you to describe your API, MSON allows you to describe data structure.

MSON can be added to resources, actions, and individual requests or responses via an `+ Attributes` section.

Creating a new question in the polls API can be modeled using MSON:

```apib
### Create a New Question [POST]
You may create your own question using this action. It takes a JSON object containing a question and a collection of answers in the form of choices.

+ Request (application/json)

    + Attributes

        + question: Favourite Language? (required)
        + choices: Swift, `Objective-C` (array, required)

```

When the above blueprint is parsed it will have a JSON body and JSON Schema example generated for it from the MSON attributes. Note, however, that the generated JSON Schema may differ from a hand-written one. In this example, the `minItems` will not be set. If you have such constraints you can override the generated schema by providing your own, in which case only the JSON body will be generated.

*Note*: MSON is still considered a beta feature!

## Data Structures

Once you start using MSON, you may find yourself wanting to reuse certain commonly used or nested data structure components. This is possible with the `## Data Structures` section. Attributes sections can then reference the data structures defined in the Data Structures or other resource sections by name.

For example, using the polls API question collection resource, we can split out the `Question` and `Choice` objects:

```apib
### List All Questions [GET]
+ Response 200 (application/json)

    + Attributes (array[Question])

## Data Structures

### Question
+ question: Favourite programming language? (required)
+ published_at: `2014-11-11T08:40:51.620Z` (required)
+ url: /questions/1 (required)
+ choices (array[Choice], required)

### Choice
+ choice: Javascript (required)
+ url: /questions/1/choices/1 (required)
+ votes: 2048 (number, required)

```

## Relation Types

Actions in a blueprint can define a semantic domain-specific meaning by defining a relation type using a `+ Relation` section. This means that an action can have a specific meaning regardless of its URI or name, and allows clients to be built based on the domain of the API rather than specific URIs.

For example, in the polls API:

```apib
## Question [/question/{id}]
### View a Question Detail [GET]
+ Relation: self

### Delete a Question [DELETE]
+ Relation: delete

## Questions Collection [/questions]
### List All Questions [GET]
+ Relation: self
```

A server or client implementation can now use this information to handle the specific API resource and action URIs. Please see the [Web Linking RFC 5988](https://tools.ietf.org/html/rfc5988) and the [IANA Link Relation Types](http://www.iana.org/assignments/link-relations/link-relations.xhtml) for more information.

## Conclusion

This tutorial has covered some advanced API Blueprint topics. For more in-depth information and other advanced topics, please see the [API Blueprint Specification](https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md).
