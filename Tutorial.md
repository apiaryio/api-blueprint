# API Blueprint Tutorial

Welcome to an API Blueprint Tutorial! This tutorial will take you though the basics of the API Blueprint language. We’re going to build an API blueprint step by step for a service called Polls – a simple API allowing consumers to view polls and vote in them. You can take a look at the [full version][Poll API Blueprint] of the blueprint used in this tutorial for reference.

> **Note:** **Additional API Blueprint Resources**
>
> + [Language Specification][specification]
> + [Examples][API Blueprint Examples]
> + [Glossary of Terms][API Blueprint Glossary of Terms]
> + [API Blueprint Map][map]
> + [Tools for API Blueprint][Tooling Section]

## API Blueprint

The first step for creating a blueprint is to specify the API Name and metadata. This step looks as follows:

```markdown
FORMAT: 1A

# Polls

Polls is a simple API allowing consumers to view polls and vote in them.
```

## Metadata

The blueprint starts wih a metadata section. In this case we have specified that `FORMAT` has the value of `1A`. The format keyword denotes the version of the API Blueprint.

## API Name & Description

The first heading in the blueprint serves as the name of your API, which in this case is "Polls". Headings start with one or more `#` symbols followed by a title. The API Name here uses one hash to distinguish it as the first level. The number of `#` you use will determine the level of the heading.

Following the heading is a description of the API. You may use further headings to break up the description section.

## Resource Groups

Now it's time to start documenting the API resources. Using the `Group` keyword at the start of a heading, we've created a group of related resources.

```markdown
# Group Questions

Resource related to questions in the API.
```

## Resource

Within the questions resource group, we have a resource called "Question Collection". This resource allows you to view a list of questions. The heading specifies the URI used to access the resource inside of square brackets at the end of the heading.

```markdown
## Question Collection [/questions]
```

### Actions

API Blueprint allows you to specify each action you may make on a resource. An
action is specified with a sub-heading inside of a resource with the name of the
action followed by the HTTP method.

```markdown
### List All Questions [GET]
```

An action should include at least one response from the server which must include a status code and may contain a body. A responses is defined as a list item within an action. Lists are created by preceding list items with either a `+`, `*` or `-`.

This action returns a `200` status code along with a JSON body.

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

> **Note:** Specifying the media type after the response status code generates a `Content-Type` HTTP header. You do not have to explicitly specify the `Content-Type` header.

The polls resource has a second action which allows you to create a new question. This action includes a description showing the structure you would send to the server to perform this action.

```markdown
### Create a New Question [POST]

You may create your own question using this action. It takes a JSON object containing a question and a collection of answers in the form of choices.

+ question (string) - The question
+ choices (array[string]) - A collection of choices.
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

This example returns a `201` status code, along with HTTP headers and a body.

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

The next resource is “Question”, which represents a single question.

```markdown
## Question [/questions/{question_id}]
```

### URI Template

The URI for the “Question” resource uses a variable component, expressed by [URI Template][]. In this case, there is an ID variable called `question_id`, represented in the URI template as `{question_id}`.

<a id="uri-parameters"></a>
### URI Parameters

URI parameters should describe  the URI using a list of Parameters. For “Question” it would be as follows:

```markdown
+ Parameters
    + question_id (number) ... ID of the Question in form of an integer
```

The `question_id` variable of the URI template is a parameter for every action on this resource. It's defined here using an arbitrary type `number`, followed by a description for the parameter.

> Refer to API Blueprint Specification's [URI Parameters Section][] for more examples.

### Actions

This resource has an action to retrieve the questions detail.

```markdown
### View a Questions Detail [GET]

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

#### Response Without a Body

This resource has a delete action. The server will return a 204 response without a body.

```markdown
### Delete [DELETE]

+ Response 204
```

## Complete Blueprint

You can find an [implementation](http://github.com/apiaryio/polls-api) of this API at http://polls.apiblueprint.org/ along with the complete [Poll API Blueprint][] in the [API Blueprint Examples][] repository. You can also enjoy it [rendered on Apiary][].

## API Blueprint Tools

Visit the [Tooling Section][] of [apiblueprint.org][] to find tools to use with API Blueprints.

> **Note:** Take a look at the [API Blueprint Glossary of Terms][] if you need clarification of some of the terms used though this document.

[GitHub Gists]:                     https://gist.github.com
[API Blueprint Glossary of Terms]:  https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md
[API Blueprint Identifier]:         https://github.com/apiaryio/api-blueprint/blob/1A/API%20Blueprint%20Specification.md#Identifiers
[HTTP Request Method]:              https://github.com/for-GET/know-your-http-well/blob/master/methods.md
[status code]:                      https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md
[message-headers]:                  https://github.com/for-GET/know-your-http-well/blob/master/headers.md
[payload]:                          https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md#payload
[URI Template]:                     https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md#uri-template
[URI Parameters Section]:           https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md#def-uriparameters-section
[Markdown pre-formatted code blocks]: http://daringfireball.net/projects/markdown/syntax#precode
[URI Parameters]: #uri-parameters
[API Blueprint Examples]: https://github.com/apiaryio/api-blueprint/tree/master/examples
[Poll API Blueprint]: https://raw.github.com/apiaryio/api-blueprint/master/examples/Polls%20API.md
[rendered on Apiary]: http://docs.pollsapi.apiary.io
[Tooling Section]: http://apiblueprint.org/#tooling
[apiblueprint.org]: http://apiblueprint.org
[specification]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md
[map]: https://github.com/apiaryio/api-blueprint/wiki/API-Blueprint-Map
