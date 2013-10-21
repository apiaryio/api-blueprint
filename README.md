![logo](https://raw.github.com/apiaryio/api-blueprint/gh-pages/assets/logo_apiblueprint.png) 

# API Blueprint 
### API design for humans
API Blueprint is a documentation-oriented API description language. A couple of semantical assumptions over the plain [Markdown](http://daringfireball.net/projects/markdown/).

API Blueprint is perfect for designing your Web API and its comprehensive documentation but also for quick prototyping and collaboration. It is easy to learn and even easier to read; after all it is just a form Markdown.

## TL;DR
+ Web API description language
+ Pure Markdown
+ Designed for humans
+ Understandable by machines

## Getting started with API Blueprint
All it really takes to describe an endpoint of your API is write something like this: 

```md
# GET /message
+ Response 200 (text/plain)
    
        Hello World!
```
        
in your favorite Markdown editor. Now you can share and discuss this API in your API repository and let GitHub to render the API documentation so others can see it. 

Jump directly to the [API Blueprint Tutorial](Tutorial.md) or browse the [interactive examples](http://apiblueprint.org) to learn more about the API Blueprint syntax.

Describing your API is only the start. The API Blueprint can be used by variety of tools from interactive documentation and code generators to API testing tools thanks to its machine-friendly face:

```javascript
{
  "_version": "1.0",
  "metadata": {},
  "name": "",
  "description": "",
  "resourceGroups": [
    {
        ...
```
[\[full listing\]](https://gist.github.com/zdne/6560278#file-gistfile1-json)

It it the task of the native API Blueprint [parser](https://github.com/apiaryio/snowcrash) or one of its [bindings](https://github.com/apiaryio/snowcrash#bindings) to "translate" the API Blueprint Markdown representation into a [machine friendly format – AST](https://github.com/apiaryio/snowcrash/wiki/API-Blueprint-AST-Media-Types).

Visit the [tooling section](http://apiblueprint.org/#tooling) of the API Blueprint website to find more about the actual tools or check the [**Developing tools for API Blueprint**](https://github.com/apiaryio/api-blueprint/wiki/Developing-tools-for-API-Blueprint) if you are interested in using API Blueprint in your tool chain.

## Learn more

+ [API Blueprint Tutorial](Tutorial.md)
+ [API Blueprint Examples](examples)
+ [API Blueprint Glossary of Terms](Glossary%20of%20Terms.md)
+ [API Blueprint Language Specification](API%20Blueprint%20Specification.md)
+ [Tools working with API Blueprint](http://apiblueprint.org/#tooling)

### Developers 

+ [API Blueprint reference parser – Snow Crash](https://github.com/apiaryio/snowcrash)
+ [Snow Crash Bindings to other languages](https://github.com/apiaryio/snowcrash#bindings)
+ [API Blueprint AST Media Types](https://github.com/apiaryio/snowcrash/wiki/API-Blueprint-AST-Media-Types)
+ [Developing tools for API Blueprint](https://github.com/apiaryio/api-blueprint/wiki/Developing-tools-for-API-Blueprint)

## Future of API Blueprint
Discuss and influence the future of API Blueprint in its [Milestones](https://github.com/apiaryio/api-blueprint/issues/milestones).
 
## Contribute
Fork & pull request.

## Have a question?
Ask at [Stack Overflow](http://stackoverflow.com/questions/tagged/apiblueprint), make sure to use the `apiblueprint` tag.

Alternatively, mention [@apiblueprint](https://twitter.com/apiblueprint). if you are a contributor, check out the [API Blueprint Developers Discussion Group](https://groups.google.com/forum/?fromgroups#!forum/apiblueprint-dev) as well as the [Issues Page](https://github.com/apiaryio/api-blueprint/issues).

## License
MIT License. See the [LICENSE](https://github.com/apiaryio/api-blueprint/blob/master/LICENSE) file.
