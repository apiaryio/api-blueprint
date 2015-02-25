# API Blueprint Basic Tutorial

Welcome to the API Blueprint Tutorial! In this tutorial you will learn about the basics to getting started with the API Blueprint language.

We’re going to build an API Blueprint for a service called Polls – a simple web service that allows consumers to view polls and vote in them.

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

At the very top of this Blueprint, you will find a metadata section. In this case we have specified that "FORMAT" has the value of "1A". The format keyword is to specify the version, or format of API Blueprint we're using. In this case 1A.

The metadata section allows you to place information for use by [tooling around API Blueprint][Tooling Section]. For example, [Apiary.io](https://apiary.io/) uses a piece of metadata called `HOST`. When specified, it allows you to specify where an implementation of the API can be found.

> **Note:** Should you need a clarification of some terms as used through this document refer to [API Blueprint Glossary of Terms][].

## Title & Description

After the metadata we have a heading, headings start with a hash (#) followed by a title. In this case `# Polls`. You can use up to 6 hashes which allows you to have sub-headings. The first heading in the Blueprint document serves as the API Name.

Then we have a description of the Polls API. Where we have mentioned what the API does. You can use further headings to break up the description sections.

## Resource Groups

Now it's time to start documenting the resources inside of the API. To start of with, we're going to can use the `Group` keyword inside a heading to specify a group of related resources. This allows us to group all of the resources related to questions in the API together.

```markdown
# Group Questions

Resource related to questions in the API.
```

## Resource

Inside of the questions resource group, we have a resource in called "Questions collection". This resource allows you to view a list of questions. We've created a sub-heading inside of this group called `Questions collection` which then specifies the URI for this resource inside of the API which is placed inside square brackets at the end of the title.

```markdown
## Questions collection [/questions]
```

### Actions

In an API Blueprint, you need to specify the actions you can make on this resource in HTTP. For example, we can retrive the list of questions using the HTTP method `GET`.

We can create a sub-heading inside this resource with a title for an action, followed by the HTTP method to use inside the square brackets.

```markdown
### List all questions [GET]
```

In API Blueprint, an action **should** always include at least one response representing the HTTP response message sent back in response to a HTTP request. The response should always include a [status code][] and possibly an additional [payload][].

For example, we can define the most common response "200" indicating the request has succeeded, along with an example result which is a JSON array of questions.

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
                        "answer": "Swift",
                        "url": "/questions/1/choices/1",
                        "votes": 2048
                    }, {
                        "answer": "Python",
                        "url": "/questions/1/choices/2",
                        "votes": 1024
                    }, {
                        "answer": "Objective-C",
                        "url": "/questions/1/choices/3",
                        "votes": 512
                    }, {
                        "answer": "Ruby",
                        "url": "/questions/1/choices/4",
                        "votes": 256
                    }
                ]
            }
        ]
```

> **Note:** API Blueprint is **indentation sensitive**. Assets have to be **indented by four spaces** relative to it's existing indentation level. In the case of list items or sections, which are already indented. It results in having you include additional indentation, this further makes it a total of **eight spaces** when using assets inside a list item.

The polls resource has a second action, allowing you to create a new question. Inside this action, we've added a description which describes the structure you would send to the server to create a new question.

```markdown
### Create a new question [POST]

You can create your own question using this action. It takes a JSON dictionary containing a question and a collection of answers in the form of choices.

- question (string) - The question
- choices (array[string]) - A collection of choices.
```

We can show an example request, in this case we're showing an example JSON request you can make to the API.

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

This example request will result in a 201 response from the server specifying we've created a new resource. The API returns a `Location` header specifying the URI for the created resource along with a JSON body.

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
                            "answer": "Swift",
                            "vote_url": "/questions/1/choices/1",
                            "votes": 0
                        }, {
                            "answer": "Python",
                            "vote_url": "/questions/1/choices/2",
                            "votes": 0
                        }, {
                            "answer": "Objective-C",
                            "vote_url": "/questions/1/choices/3",
                            "votes": 0
                        }, {
                            "answer": "Ruby",
                            "vote_url": "/questions/1/choices/4",
                            "votes": 0
                        }
                    ]
                }
```

The next resource in this group allows you to view the detail of a question directly with an ID of a question.

```markdown
## Question [/questions/{question_id}]
```

### URI Template

The URI for “Question” resource uses a variable component, expressed by [URI Template][]. In this case, we have an id variable as `{question_id}`. Representing this resource is for `/questions/{question_id}` where `question_id` can be substituted for a real `id`.

<a id="uri-parameters"></a>
### URI Parameters

You can describe the parameters in the URI using a list of Parameters. For “Question” it would be as follows:

```markdown
+ Parameters
    + question_id (number) ... ID of the Question in form of an integer
```

The *"question_id"* variable of the URI template is a parameter to every action on this resource. Here defined of an arbitrary type *"number"* and followed by a description for the parameter.

> Refer to API Blueprint Specification's [Resource Parameters Section][] for additional examples.

### Actions

Similar to before, we're going to describe a new action which allows you to view a questions detail.

```markdown
### View a questions detail [GET]

+ Response 200 (application/json)

            {
                "question": "Favourite programming language?",
                "published_at": "2014-11-11T08:40:51.620Z",
                "url": "/questions/1",
                "choices": [
                    {
                        "answer": "Swift",
                        "url": "/questions/1/choices/1",
                        "votes": 2048
                    }, {
                        "answer": "Python",
                        "url": "/questions/1/choices/2",
                        "votes": 1024
                    }, {
                        "answer": "Objective-C",
                        "url": "/questions/1/choices/3",
                        "votes": 512
                    }, {
                        "answer": "Ruby",
                        "url": "/questions/1/choices/4",
                        "votes": 256
                    }
                ]
            }
```

#### Response without a body

You can describe a response without a body, for example a 204 response when we delete a question:

```
### Delete [DELETE]
+ Response 204
```

## Complete Blueprint

You can find the complete Poll API Blueprint [full listing][] in the [API Blueprint Examples][] repository.

## API Blueprint Tools

With Poll Blueprint completed it is time to put it at work. For the start you can browse this API [rendered by GitHub][] or enjoy it [rendered by Apiary][].

Visit the [Tooling Section][] of [apiblueprint.org][] to find tools that you can use with API Blueprints.

[GitHub Gists]:                     https://gist.github.com
[API Blueprint Glossary of Terms]:  https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md
[Markdown Tutorial]:                http://www.markdowntutorial.com
[Gruber's Original]:                http://daringfireball.net/projects/markdown/syntax
[API Blueprint Identifier]:         https://github.com/apiaryio/api-blueprint/blob/1A/API%20Blueprint%20Specification.md#Identifiers
[HTTP Request Method]:              https://github.com/for-GET/know-your-http-well/blob/master/methods.md
[status code]:                      https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md
[message-headers]:                  https://github.com/for-GET/know-your-http-well/blob/master/headers.md
[payload]:                          https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md#payload
[`application/hal+json`]:           https://github.com/mikekelly/hal_specification
[URI Template]:                     https://github.com/apiaryio/api-blueprint/blob/master/Glossary%20of%20Terms.md#uri-template
[Resource Parameters Section]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md#ResourceParametersSection
[Markdown pre-formatted code blocks]: http://daringfireball.net/projects/markdown/syntax#precode
[GitHub-flavored Markdown]: https://help.github.com/articles/github-flavored-markdown
[fenced code blocks]:https://help.github.com/articles/github-flavored-markdown#fenced-code-blocks
[URI Parameters]: #uri-parameters
[API Blueprint Examples]: https://github.com/apiaryio/api-blueprint/tree/master/examples
[full listing]: https://raw.github.com/apiaryio/api-blueprint/master/examples/Polls%20API.md
[rendered by GitHub]: https://github.com/apiaryio/api-blueprint/blob/master/examples/Polls%20API.md
[rendered by Apiary]: http://docs.pollsapi.apiary.io
[Tooling Section]: http://apiblueprint.org/#tooling
[apiblueprint.org]: http://apiblueprint.org
[specification]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md
[map]: https://github.com/apiaryio/api-blueprint/wiki/API-Blueprint-Map
