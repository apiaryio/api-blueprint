![logo](https://raw.github.com/apiaryio/api-blueprint/master/assets/logo_apiblueprint.png)

# API Blueprint
### API Design for Humans

[![slack](https://apiblueprint-slack.herokuapp.com/badge.svg)](http://apiblueprint-slack.herokuapp.com/)

A powerful high-level API design language for web APIs.

API Blueprint is simple and accessible to everybody involved in the API design
lifecycle. Its syntax is concise yet expressive.

With API Blueprint you can quickly prototype and model APIs to be created or
describe already deployed mission-critical APIs. From a [car][tesla] to the
largest Content Distribution Network (CDN) in the world.

The API Blueprint is built to encourage dialogue and collaboration between
project stakeholders, developers and customers at any point in the API
lifecycle. At the same time, the API Blueprint [tools][] provide the support to
achieve the goals be it API development, governance or delivery.

![API Blueprint Lifecycle](assets/lifecycle.png)

[tesla]: https://github.com/timdorr/model-s-api/blob/master/apiary.apib
[tools]: http://apiblueprint.org/#tooling

## Open Source
API Blueprint is completely open sourced under the MIT license.
Any [contribution][contribute] is highly appreciated.

[contribute]: #Contribute

## At home on GitHub
API Blueprint language is recognized by GitHub. You can
[search for API Blueprint][search] or use the `apib` language identifier for
[syntax highlighting][gfm].

[search]: https://github.com/search?utf8=%E2%9C%93&q=language%3A%22API+Blueprint%22&type=Repositories&ref=advsearch&l=API+Blueprint&l=

[gfm]: https://help.github.com/articles/github-flavored-markdown/#syntax-highlighting

## Getting started
All it takes to describe an endpoint of your API is to write:

```apib
# GET /message
+ Response 200 (text/plain)

        Hello World!
```

in your favorite plain text editor.

With this blueprint you can already get a [mock][], [documentation][] and
[test][] for your API before you even start coding.

To learn more about the API Blueprint syntax jump directly to the
[API Blueprint Tutorial][tutorial] or take a look at some [examples][].

[mock]: http://docs.apibstart.apiary.io/#reference/0/message/get?console=1
[documentation]: http://docs.apibstart.apiary.io
[test]: http://dredd.readthedocs.org/en/latest/
[tutorial]: Tutorial.md
[examples]: https://github.com/apiaryio/api-blueprint/tree/master/examples

## Media Type
The media type for API Blueprint is `text/vnd.apiblueprint`.

## Learn more
- [Tutorial][tutorial]
- [Advanced Tutorial][advanced_tutorial]
- [Examples][examples]
- [Wiki][wiki]
- [Glossary of Terms][glossary]
- [Specification][specification]
- [List of Tools][tools]
- [Developers][developers]

[advanced_tutorial]: Advanced%20Tutorial.md
[glossary]: Glossary%20of%20Terms.md
[specification]: API%20Blueprint%20Specification.md
[wiki]: https://github.com/apiaryio/api-blueprint/wiki
[developers]: https://github.com/apiaryio/api-blueprint/wiki/Developers

## Future
The plans for API Blueprint are completely tracked on GitHub – see the
[API Blueprint Roadmap][roadmap].

[roadmap]: https://github.com/apiaryio/api-blueprint/wiki/Roadmap

## Developers
Building tools for API Blueprint is possible thanks to its machine-friendly face
provided by API Blueprint parser.

If you are interested in building tools for API Blueprint check out the
[Developing tools for API Blueprint][developers].

## Contribute
Feel free report problems or propose new ideas using the API Blueprint GitHub
[issues][].

We use an RFC process for proposing any substantial changes to the API
Blueprint language, specification and/or parsers.

If you would like to propose a change, please consult our
[RFC process][rfc].

[issues]: https://github.com/apiaryio/api-blueprint/issues
[rfc]: https://github.com/apiaryio/api-blueprint-rfcs

## Get in Touch
- [@apiblueprint](https://twitter.com/apiblueprint)
- [Slack](https://apiblueprint-slack.herokuapp.com/)
- [Stack Overflow](http://stackoverflow.com/questions/tagged/apiblueprint)
- [GitHub Issues][issues]

## License
MIT License. See the [LICENSE](https://github.com/apiaryio/api-blueprint/blob/master/LICENSE)
file.
