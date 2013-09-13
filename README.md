![logo](https://raw.github.com/apiaryio/api-blueprint/gh-pages/assets/logo_apiblueprint.png) 

# API Blueprint 
### API design for humans
API Blueprint is a documentation-oriented API description language. A couple of semantic assumptions over a [Markdown](http://daringfireball.net/projects/markdown/).

API Blueprint is perfect for designing your Web API and its comprehensive documentation but also for quick prototyping and collaboration. It is easy to learn and even easier to read; after all it is just a form Markdown.

## TL;DR
+ Web API description language
+ Pure Markdown
+ Designed for humans
+ Understandable by machines

## Getting started with API Blueprint
All it really takes to describe an endpoint of your API is **write** something like this: 

```md
# GET /message
+ Response 200 (text/plain)
	
	Hello World!
```
		
in your favorite Markdown editor. Now you can **share** and **discuss** this API in your API repository and let GitHub to render the API documentation so others can **see** it. 

Jump directly to the [API Blueprint Tutorial](https://github.com/apiaryio/api-blueprint/blob/master/examples/1.%20Simplest%20API.md) or browse the [interactive examples](http://apiblueprint.org/#examples) to learn more about the API Blueprint syntax.

**Describing your API is only the start**. API Blueprint has a **machine friendly** face too! Thanks to the native API Blueprint [parser](https://github.com/apiaryio/snowcrash) or one of its [bindings](https://github.com/apiaryio/snowcrash#bindings) which "translates" the API Blueprint Markdown representation into a [machine friendly format – AST](https://github.com/apiaryio/snowcrash/wiki/API-Blueprint-AST-Media-Types)the API Blueprint can be used by variety of **tools** from interactive documentation and code generators to API testing tools.

Visit the [tooling section](http://apiblueprint.org/#tooling) of the API Blueprint website to find more about the actual tools or keep on reading should you be interested in **using API Blueprint in your tool chain**.

## Learn more
+ [API Blueprint Glossary of Terms](https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md)
+ [API Blueprint Language Specification](https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md)
+ [Snow Crash – the API Blueprint reference parser](https://github.com/apiaryio/snowcrash)

## Future of API Blueprint
Discuss and influence the future of API Blueprint in its [Milestones](https://github.com/apiaryio/api-blueprint/issues/milestones).
 
## Contribute
Fork & pull request.

## Have a question?
Ask at [Stack Overflow](http://stackoverflow.com/questions/ask), make sure to use the `apiblueprint` tag.

Alternatively, if you are a contributor, check out the [API Blueprint Developers Discussion Group](https://groups.google.com/forum/?fromgroups#!forum/apiblueprint-dev) as well as the [Issues Page](https://github.com/apiaryio/api-blueprint/issues).

## Developing tools for API Blueprint
It is best to consume the API Blueprint AST directly either via a **[binding](https://github.com/apiaryio/snowcrash#bindings) interface** or the [**native parser interface**](https://github.com/apiaryio/snowcrash/blob/master/src/Blueprint.h).

Alternatively, you can use the parser [command line tool](https://github.com/apiaryio/snowcrash#snow-crash-command-line-tool) and then process its output [AST media type](https://github.com/apiaryio/snowcrash/wiki/API-Blueprint-AST-Media-Types).

### Using a parser binding (Node.js)

1. Install binding for your language (e.g. [Protagonist](https://github.com/apiaryio/protagonist) for Node.js)

	```sh
	$ npm install protagonist
	```

2. Parse your API Blueprint into its AST

	```javascript
	var protagonist = require('protagonist');

	var blueprint = '''
	# GET /message
	+ Response 200 (text/plain)

			Hello World!
	''';

	protagonist.parse(blueprint, function(err, result) {

		...
	});
	```

### Using the command line tool

1. Get Snow Crash command line tool

	```sh
	$ brew install --HEAD \
		https://raw.github.com/apiaryio/snowcrash/master/tools/homebrew/snowcrash.rb
	```

	Build notes for [Linux](https://github.com/apiaryio/snowcrash#snow-crash-command-line-tool) and [Windows](https://github.com/apiaryio/snowcrash/wiki/Building-on-Windows).

2. Parse API Blueprint into its AST media type

	```sh
	$ cat << 'EOF' | snowcrash --format json
	# GET /message
	+ Response 200 (text/plain)
	
			Hello World!
	EOF
	{
	  "_version": "1.0",
	  "metadata": {},
	  "name": "My API",
	  "description": "",
	 
	 ...
	```

### Using the native parser interface (C/C++)

1. Build Snow Crash

	```sh
	$ ./configure
	$ make
	```

	See full [build instructions](https://github.com/apiaryio/snowcrash#build)

2. Parse your API Blueprint into its AST

	```c++
	#include "snowcrash.h"

	snowcrash::SourceData blueprint = R"(
	# GET /message
	+ Response 200 (text/plain)

			Hello World!
	)";
	snowcrash::Result result;
	snowcrash::Blueprint ast;
	
	snowcrash::parse(blueprint, 0, result, ast);
	
	...
	```	

## License
MIT License. See the [LICENSE](https://github.com/apiaryio/api-blueprint/blob/master/LICENSE) file.
