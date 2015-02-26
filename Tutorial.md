# API Blueprint Tutorial

Welcome to an API Blueprint Tutorial! In this tutorial you will learn about the basics of the API Blueprint language.

In this tutorial, we’re going to build an API Blueprint for a service called Polls – a simple web service that allows consumers to view polls and vote in them.

> **Note:** **Additional API Blueprint Resources**
>
> + [Language Specification][specification]
> + [Examples][API Blueprint Examples]
> + [Glossary of Terms][API Blueprint Glossary of Terms]
> + [API Blueprint Map][map]
> + [Tools for API Blueprint][Tooling Section]

## API Blueprint

The start of the Blueprint is going to look as follows:

```markdown
FORMAT: 1A

# Polls

Polls is a simple web service that allows consumers to view polls and vote in them.
```

## Metadata

At the very top of this Blueprint, you will find a metadata section. In this case we have specified that `FORMAT` has the value of `1A`. The format keyword is used to specify the version of the API Blueprint. In this case 1A.

## API Name & Description

After the metadata we have a heading, headings start with a hash (#) followed by a title. In this case `# Polls`. You can use up to 6 hashes which allows you to have sub-headings. The first heading in the Blueprint document serves as the API Name.

Afterwards, there is a description of the Polls API, this mentions what the API is used for. You can use further headings to break up the description sections.

## Resource Groups

Now it's time to start documenting the resources inside of the API. To start of with, the `Group` keyword is used inside a heading to specify a group of related resources.

```markdown
# Group Questions

Resource related to questions in the API.
```

## Resource

Inside of the questions resource group, we have a resource called "Questions collection". This resource allows you to view a list of questions. The heading specifies the URI used to access the resource inside of square brackets at the end of the heading.

```markdown
## Questions collection [/questions]
```

### Actions

API Blueprint allows you to specify the actions you can make on each resource. A sub-heading inside of the resource with a title, followed by the HTTP method to use inside the square brackets.

```markdown
### List all questions [GET]
```

Action's should always include at least one response representing the HTTP response message sent back in response to a HTTP request. The response should always include a [status code][] and possibly a body.

This action returns a `200` status code along with a JSON body.

> **Note:** Specifying the media type in parenthesis after the response status codes generates implicit `Content-Type` HTTP header. Therefore you do not have to explicitly specify the `Content-Type` header.

```markdown
+ Response 200 (application/json)

        [
            {
                "question": "Favourite programming language?",
                "published_at": "2014-11-11T08:40:51.620Z",
                "url": "/questions/1",
                "choices": [
                    {
                        "choice": "Swift",
                        "url": "/questions/1/choices/1",
                        "votes": 2048
                    }, {
                        "choice": "Python",
                        "url": "/questions/1/choices/2",
                        "votes": 1024
                    }, {
                        "choice": "Objective-C",
                        "url": "/questions/1/choices/3",
                        "votes": 512
                    }, {
                        "choice": "Ruby",
                        "url": "/questions/1/choices/4",
                        "votes": 256
                    }
                ]
            }
        ]
```

The polls resource has a second action, allowing you to create a new question. Inside this action, there is a description for the structure you would send to the server to create a new question.

```markdown
### Create a new question [POST]

You can create your own question using this action. It takes a JSON dictionary containing a question and a collection of answers in the form of choices.

- question (string) - The question
- choices (array[string]) - A collection of choices.
```

This action takes a JSON payload as part of the request as follows:

```markdown
+ Request (application/json)

            {
                "question": "Favourite programming language?",
                "choices": [
                    "Swift",
                    "Python",
                    "Objective-C",
                    "Ruby"
                ]
            }
```

This example returns a 201 status code, along with HTTP headers and a JSON Body.

```markdown
+ Response 201 (application/json)

    + Headers

            Location: /questions/1

    + Body

                {
                    "question": "Favourite programming language?",
                    "published_at": "2014-11-11T08:40:51.620Z",
                    "url": "/questions/1",
                    "choices": [
                        {
                            "choice": "Swift",
                            "url": "/questions/1/choices/1",
                            "votes": 0
                        }, {
                            "choice": "Python",
                            "url": "/questions/1/choices/2",
                            "votes": 0
                        }, {
                            "choice": "Objective-C",
                            "url": "/questions/1/choices/3",
                            "votes": 0
                        }, {
                            "choice": "Ruby",
                            "url": "/questions/1/choices/4",
                            "votes": 0
                        }
                    ]
                }
```

The next resource is “Question”, it allows you to view a single question directly with an ID of a “Question”.

```markdown
## Question [/questions/{question_id}]
```

### URI Template

The URI for the “Question” resource uses a variable component, expressed by [URI Template][]. In this case, we have an id variable called `{question_id}. Where `question_id` is substituted for a real `id`.

<a id="uri-parameters"></a>
### URI Parameters

URI parameters can be described in the URI using a list of Parameters. For “Question” it would be as follows:

```markdown
+ Parameters
    + question_id (number) ... ID of the Question in form of an integer
```

The "`question_id` variable of the URI template is a parameter for every action on this resource. Here defined of an arbitrary type `number`, followed by a description for the parameter.

> Refer to API Blueprint Specification's [Resource Parameters Section][] for additional examples.

### Actions

Similar to before, this resource has an action to view the question detail.

```markdown
### View a questions detail [GET]

+ Response 200 (application/json)

            {
                "question": "Favourite programming language?",
                "published_at": "2014-11-11T08:40:51.620Z",
                "url": "/questions/1",
                "choices": [
                    {
                        "choice": "Swift",
                        "url": "/questions/1/choices/1",
                        "votes": 2048
                    }, {
                        "choice": "Python",
                        "url": "/questions/1/choices/2",
                        "votes": 1024
                    }, {
                        "choice": "Objective-C",
                        "url": "/questions/1/choices/3",
                        "votes": 512
                    }, {
                        "choice": "Ruby",
                        "url": "/questions/1/choices/4",
                        "votes": 256
                    }
                ]
            }
```

#### Response without a body

This resource has a delete action, the server will return a 204 response without a body.

```
### Delete [DELETE]
+ Response 204
```

## Complete Blueprint

You can find an implementation of this API at `http://polls.apiblueprint.org/` along with the complete [Poll API Blueprint][] in the [API Blueprint Examples][] repository, or you can enjoy it [rendered on Apiary][].

## API Blueprint Tools

Visit the [Tooling Section][] of [apiblueprint.org][] to find tools that you can use with API Blueprints.

> **Note:** Should you need a clarification of some terms as used through this document refer to [API Blueprint Glossary of Terms][].

[GitHub Gists]:                     https://gist.github.com
[API Blueprint Glossary of Terms]:  https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md
[API Blueprint Identifier]:         https://github.com/apiaryio/api-blueprint/blob/1A/API%20Blueprint%20Specification.md#Identifiers
[HTTP Request Method]:              https://github.com/for-GET/know-your-http-well/blob/master/methods.md
[status code]:                      https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md
[message-headers]:                  https://github.com/for-GET/know-your-http-well/blob/master/headers.md
[payload]:                          https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md#payload
[URI Template]:                     https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md#uri-template
[Resource Parameters Section]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md#ResourceParametersSection
[Markdown pre-formatted code blocks]: http://daringfireball.net/projects/markdown/syntax#precode
[URI Parameters]: #uri-parameters
[API Blueprint Examples]: https://github.com/apiaryio/api-blueprint/tree/master/examples
[Poll API Blueprint]: https://raw.github.com/apiaryio/api-blueprint/master/examples/Polls%20API.md
[rendered on Apiary]: http://docs.pollsapi.apiary.io
[Tooling Section]: http://apiblueprint.org/#tooling
[apiblueprint.org]: http://apiblueprint.org
[specification]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md
[map]: https://github.com/apiaryio/api-blueprint/wiki/API-Blueprint-Map
