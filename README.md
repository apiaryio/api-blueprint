# API Blueprint
**A Web API documentation language**

```markdown
# GET /info
+ Response 200 (text/plain)
	
    Hello World!
```

## Version
+ Actual version: [Format 1A](https://github.com/apiaryio/api-blueprint/blob/master/APIBlueprintSpecification.md)

## What is API Blueprint?

### TL;DR: API Blueprint is:
+ Web API documentation language
+ Pure Markdown
+ Designed for humans
+ Understandable by machines


API Blueprint is lightweight, documentation oriented domain specific language (DSL) for easily designing, building and documenting REST API. **API Blueprint is a Markdown.** It is easy to learn and read, perfect for comprehensive documentation but also for quick prototyping and collaboration.

## Write it, read it, share it

### Stay clean & tidy:

```markdown
# My API
My API rocks! 
 
## GET /resource
+ response 200 (application/json)
	
		{ "message": 'hello world' }
```

### or go large:

```markdown
My API
======

My API rocks! 

GET /resource
-------------
+ Response 200 (application/json)
	+ Body
		
		{ "message": 'hello world' }
```


## Parse it, integrate it

### Command-line interface

**JSON:** 
```
$ snowcrash parse --json my_api.md
{
  "metadata": [],
  "name": "My API",
  "description": "My API rocks! \n \n",
  "resourceGroups": [
    {
      "name": "",
      "description": "",
      "resources": [
        {
          "uri": "/resource",
          "description": "",
          "headers": [],
          "methods": [
            {
              "method": "GET",
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
                  "body": "{ ... }\n",
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

**YAML:**
```
$ showcrash parse --yaml my_api.md
name: My API
description: "My API rocks! \n \n"
resourceGroups:
- name:
  description:
  resources:
  - uri: /resource
    description:
    methods:
    - method: GET
      description:
      responses:
      - name: 200
        description:
        body: "{ ... }\n"
        schema:
        headers:
        - Content-Type: application/json
```
### Bindings

- **Node.js:** [Protagonist](https://github.com/apiaryio/protagonist)
- **Ruby:** not yet, call for contributions! 
- **Java:** not yet, call for contributions!
- **PHP:** not yet, call for contributions!



## Getting started

#### OS X 
```
$ brew install snowcrash
$ showcrash help
```

#### Build it

```
$ git clone https://github.com/apiaryio/snowcrash
$ cd showcrash
$ ./configure
$ make
$ make install
```

## Have a question?
Ask at [Stack Overflow](http://stackoverflow.com), make sure to use `apiblueprint` tag.

## License
MIT License. See [LICENSE](https://github.com/apiaryio/api-blueprint/blob/master/LICENSE) file.
