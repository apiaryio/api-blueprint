# API Blueprint – A Web API documentation language

```markdown
# GET /message
+ Response 200 (text/plain)
	
    Hello World!
```

## What is API Blueprint?

API Blueprint is a lightweight, documentation-oriented domain specific language (DSL) for easily designing, building and documenting Web APIs. **API Blueprint is a form of Markdown.** It is easy to learn and read; perfect for comprehensive documentation but also for quick prototyping and collaboration.

## TL;DR

+ Web API documentation language
+ Pure Markdown
+ Designed for humans
+ Understandable by machines

## Write, read and share

Prototype, design and document your API using a Markdown formatting of your liking.

### Stay clean & tidy

```markdown
# My API
My API rocks! 
 
## GET /message
- response 200 (application/json)
	
		{ "message": 'Hello World!' }
```

### or go large

```markdown
My API
======

My API rocks! 

GET /message
-------------

+ Response 200 (application/json)

		{ 
			"message": 'Hello World!' 
		}
```

## Parse & integrate
Parse your API Blueprint and integrate with your tools & frameworks.

### Use a Command-line interface

#### JSON

```sh
$ snowcrash parse --json my_api.md
```

```js
{
  "metadata": [],
  "name": "My API",
  "description": "My API rocks! \n\n",
  "resourceGroups": [
    {
      "name": "",
      "description": "",
      "resources": [
        {
          "uriTemplate": "/message",
          "name": "",
          "description": "",
          "headers": [],
          "object": {
            "name": "",
            "description": "",
            "headers": [],
            "body": "",
            "schema": ""
          },
          "methods": [
            {
              "method": "GET",
              "name": "",
              "description": "",
              "headers": [],
              "requests": [],
              "responses": [
                {
                  "name": "200",
                  "description": "",
                  "headers": [
                    {
                      "name": "Content-Type",
                      "value": "application/json"
                    }
                  ],
                  "body": "{ \"message\": 'Hello World!' }    \n",
                  "schema": ""
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

#### YAML

```sh
$ snowcrash parse --yaml my_api.md
```

```yaml
name: My API
description: "My API rocks! \n\n"
resourceGroups:
- name:
  description:
  resources:
  - uri: /message
    name:
    description:
    object:
    methods:
    - method: GET
      name:
      description:
      responses:
      - name: 200
        description:
        body: "{ "message": 'Hello World!' }\n"
        schema:
        headers:
        - Content-Type: application/json
```

## Getting started

### View examples

Start with the [API Blueprint Tutorial](https://github.com/apiaryio/api-blueprint/blob/master/examples/1.%20Simplest%20API.md) or just browse the [examples](https://github.com/apiaryio/api-blueprint/tree/master/examples).

### Get the API Blueprint Parser

Get [Snow Crash](https://github.com/apiaryio/snowcrash) – the Canonical API Blueprint Parser. 

### Or one of its bindings 

Refer to the Snow Crash [bindings]((https://github.com/apiaryio/snowcrash#bindings).

- **Node.js:** [Protagonist](https://github.com/apiaryio/protagonist)
- **Ruby:** none yet - we're looking for contributors
- **Java:** none yet - we're looking for contributors
- **PHP:** none yet - we're looking for contributors

## Have a question?
Ask at [Stack Overflow](http://stackoverflow.com/questions/ask), make sure to use the `apiblueprint` tag.

Alternatively, if you are a contributor, check out the [API Blueprint Developers Discussion Group](https://groups.google.com/forum/?fromgroups#!forum/apiblueprint-dev). 

## Version
+ Actual version: [Format 1A](https://github.com/apiaryio/api-blueprint/blob/master/APIBlueprintSpecification.md)

## What's next?

### API Blueprint Roadmap

Refer to the API Blueprint Roadmap [Wiki Page](https://github.com/apiaryio/api-blueprint/wiki/API-Blueprint-Roadmap).

### Brew Parser

_not ready yet, work in progress_

```sh
$ brew install snowcrash
$ snowcrash --help
```

## License
MIT License. See the [LICENSE](https://github.com/apiaryio/api-blueprint/blob/master/LICENSE) file.
