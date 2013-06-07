# API Blueprint
**A Web API documentation language**

```markdown
# GET /info
+ Response 200 (text/plain)
	
    Hello World!
```

## Version
+ Actual version: [Format 1A](https://github.com/apiaryio/api-blueprint/blob/master/APIBlueprintSpecification.md)

## What?

### TL;DR: API Blueprint is:
+ Web API documentation language
+ Pure Markdown
+ Designed for humans
+ Understandable by machines

API Blueprint is lightweight domain specific language (DSL) for easily designing, building and documenting REST API. API Blueprint is a Markdown. It is easy to learn and read, perfect for quick prototyping and collaboration but also for comprehensive documentation.

## Have it your way

### Stay clean & tidy:

```markdown
# My API
My API rocks! 
 
## GET /resource
+ response 200 (application/json)
	
		{ ... }
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
		
			{ ... }
```
				
### and let your machines have fun with:

```javascript
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

### or

```yaml
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

## Have question?
Ask at [Stack Overflow](http://stackoverflow.com), make sure to use `apiblueprint` tag.

## Get started
Use canonical API Blueprint parser – [Snow Crash](https://github.com/apiaryio/snowcrash) or one of its [bindings](https://github.com/apiaryio/snowcrash#bindings).

## License
MIT License. See [LICENSE](https://github.com/apiaryio/api-blueprint/blob/master/LICENSE) file.
