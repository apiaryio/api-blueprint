FORMAT: 1A
HOST: http://polls.apiblueprint.org/

# Polls

Polls is a simple API allowing consumers to view polls and vote in them. You can view this documentation over at [Apiary](http://docs.pollshypermedia.apiary.io/).

# Polls API Root [/]

This resource does not have any attributes. Instead it offers the initial API affordances.

## Retrieve the Entry Point [GET]

+ Response 200 (application/vnd.siren+json)

        {
            "links": [
                {
                    "rel": [ "questions" ],
                    "href": "/questions"
                }
            ]
        }

+ Response 200 (application/hal+json)

        {
            "_links": {
                "questions": { "href": "/questions" }
            }
        }

## Questions Collection [/questions{?page}]

+ Parameters
    + page (optional, number, `1`) ... The page of questions to return

### List All Questions [GET]

+ Response 200 (application/vnd.siren+json)

        {
            "actions": [
                {
                    "name": "add",
                    "href": "/questions",
                    "method": "POST",
                    "type": "application/json",
                    "fields": [
                        {
                            "name": "question"
                        }, {
                            "name": "choices"
                        }
                    ]
                }
            ],
            "links": [
                {
                  "rel": [ "next" ],
                  "href": "/questions?page=2"
                },
                {
                  "rel": [ "self" ],
                  "href": "/questions"
                }
            ],
            "entities": [
                {
                    "actions": [
                        {
                            "name": "delete",
                            "href": "/questions/1",
                            "method": "DELETE"
                        }
                    ],
                    "rel": [ "question" ],
                    "properties": {
                        "published_at": "2014-11-11T08:40:51.620Z",
                        "question": "Favourite programming language?"
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1"
                        }
                    ],
                    "entities": [
                        {
                            "actions": [
                                {
                                    "name": "vote",
                                    "href": "/questions/1/choices/1",
                                    "method": "POST"
                                }
                            ],
                            "rel": [ "choice" ],
                            "properties": {
                                "choice": "Swift",
                                "votes": 2048
                            },
                            "links": [
                                {
                                    "rel": [ "self" ],
                                    "href": "/questions/1/choices/1"
                                }
                            ]
                        }, {
                            "actions": [
                                {
                                    "name": "vote",
                                    "href": "/questions/1/choices/2",
                                    "method": "POST"
                                }
                            ],
                            "rel": [ "choice" ],
                            "properties": {
                                "choice": "Python",
                                "votes": 1024
                            },
                            "links": [
                                {
                                    "rel": [ "self" ],
                                    "href": "/questions/1/choices/2"
                                }
                            ]
                        }, {
                            "actions": [
                                {
                                    "name": "vote",
                                    "href": "/questions/1/choices/3",
                                    "method": "POST"
                                }
                            ],
                            "rel": [ "choice" ],
                            "properties": {
                                "choice": "Objective-C",
                                "votes": 512
                            },
                            "links": [
                                {
                                    "rel": [ "self" ],
                                    "href": "/questions/1/choices/3"
                                }
                            ]
                        }, {
                            "actions": [
                                {
                                    "name": "vote",
                                    "href": "/questions/1/choices/4",
                                    "method": "POST"
                                }
                            ],
                            "rel": [ "choice" ],
                            "properties": {
                                "choice": "Ruby",
                                "votes": 256
                            },
                            "links": [
                                {
                                    "rel": [ "self" ],
                                    "href": "/questions/1/choices/4"
                                }
                            ]
                        }
                    ]
                }
            ]
        }

+ Response 200 (application/hal+json)

        {
            "_links": {
                "self": { "href": "/questions" },
                "next": { "href": "/questions?page=2" }
            },
            "_embedded": {
                "question": [
                    {
                        "_links": {
                            "self": { "self": "/questions/1" }
                        },
                        "_embedded": {
                            "choice": [
                                {
                                    "_links": {
                                        "self": { "self": "/questions/1/choices/1" }
                                    },
                                    "choice": "Swift",
                                    "votes": 2048
                                }, {
                                    "_links": {
                                        "self": { "self": "/questions/1/choices/2" }
                                    },
                                    "choice": "Python",
                                    "votes": 1024
                                }, {
                                    "_links": {
                                        "self": { "self": "/questions/1/choices/3" }
                                    },
                                    "choice": "Objective-C",
                                    "votes": 512
                                }, {
                                    "_links": {
                                        "self": { "self": "/questions/1/choices/4" }
                                    },
                                    "choice": "Ruby",
                                    "votes": 256
                                }
                            ]
                        },
                        "question": "Favourite programming language?",
                        "published_at": "2014-11-11T08:40:51.620Z"
                    }
                ]
            }
        }

### Create a New Question [POST]

You may create your own question using this action. It takes a JSON object containing a question and a collection of answers in the form of choices.

+ question (string) - The question
+ choices (array[string]) - A collection of choices.

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

+ Response 201 (application/vnd.siren+json)

        {
            "actions": [
                {
                    "name": "delete",
                    "href": "/questions/1",
                    "method": "DELETE"
                }
            ],
            "properties": {
                "published_at": "2014-11-11T08:40:51.620Z",
                "question": "Favourite programming language?"
            },
            "links": [
                {
                    "rel": [ "self" ],
                    "href": "/questions/1"
                }
            ],
            "entities": [
                {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/1",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Swift",
                        "votes": 2048
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/1"
                        }
                    ]
                }, {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/2",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Python",
                        "votes": 1024
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/2"
                        }
                    ]
                }, {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/3",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Objective-C",
                        "votes": 512
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/3"
                        }
                    ]
                }, {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/4",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Ruby",
                        "votes": 256
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/4"
                        }
                    ]
                }
            ]
        }

+ Response 201 (application/hal+json)

        {
            "_links": {
                "self": { "href": "/questions/1" }
            },
            "_embedded": {
                "choices": [
                    {
                        "_links": {
                            "self": { "self": "/questions/1/choices/1" }
                        },
                        "choice": "Swift",
                        "votes": 2048
                    }, {
                        "_links": {
                            "self": { "self": "/questions/1/choices/2" }
                        },
                        "choice": "Python",
                        "votes": 1024
                    }, {
                        "_links": {
                            "self": { "self": "/questions/1/choices/3" }
                        },
                        "choice": "Objective-C",
                        "votes": 512
                    }, {
                        "_links": {
                            "self": { "self": "/questions/1/choices/4" }
                        },
                        "choice": "Ruby",
                        "votes": 256
                    }
                ]
            },
            "published_at": "2014-11-11T08:40:51.620Z",
            "question": "Favourite programming language?"
        }

## Group Question

Resources related to questions in the API.

## Question [/questions/{question_id}]

A Question object has the following attributes:

+ question
+ published_at - An ISO8601 date when the question was published.
+ url
+ choices - An array of Choice objects.

+ Parameters
    + question_id (required, number, `1`) ... ID of the Question in form of an integer

### View a Questions Detail [GET]

+ Response 200 (application/vnd.siren+json)

        {
            "actions": [
                {
                    "name": "delete",
                    "href": "/questions/1",
                    "method": "DELETE"
                }
            ],
            "properties": {
                "published_at": "2014-11-11T08:40:51.620Z",
                "question": "Favourite programming language?"
            },
            "links": [
                {
                    "rel": [ "self" ],
                    "href": "/questions/1"
                }
            ],
            "entities": [
                {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/1",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Swift",
                        "votes": 2048
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/1"
                        }
                    ]
                }, {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/2",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Python",
                        "votes": 1024
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/2"
                        }
                    ]
                }, {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/3",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Objective-C",
                        "votes": 512
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/3"
                        }
                    ]
                }, {
                    "actions": [
                        {
                            "name": "vote",
                            "href": "/questions/1/choices/4",
                            "method": "POST"
                        }
                    ],
                    "rel": [ "choices" ],
                    "properties": {
                        "choice": "Ruby",
                        "votes": 256
                    },
                    "links": [
                        {
                            "rel": [ "self" ],
                            "href": "/questions/1/choices/4"
                        }
                    ]
                }
            ]
        }

+ Response 200 (application/hal+json)

        {
            "_links": {
                "self": { "href": "/questions/1" }
            },
            "_embedded": {
                "choices": [
                    {
                        "_links": {
                            "self": { "self": "/questions/1/choices/1" }
                        },
                        "choice": "Swift",
                        "votes": 2048
                    }, {
                        "_links": {
                            "self": { "self": "/questions/1/choices/2" }
                        },
                        "choice": "Python",
                        "votes": 1024
                    }, {
                        "_links": {
                            "self": { "self": "/questions/1/choices/3" }
                        },
                        "choice": "Objective-C",
                        "votes": 512
                    }, {
                        "_links": {
                            "self": { "self": "/questions/1/choices/4" }
                        },
                        "choice": "Ruby",
                        "votes": 256
                    }
                ]
            },
            "published_at": "2014-11-11T08:40:51.620Z",
            "question": "Favourite programming language?"
        }

## Choice [/questions/{question_id}/choices/{choice_id}]

+ Parameters
    + question_id (required, number, `1`) ... ID of the Question in form of an integer
    + choice_id (required, number, `1`) ... ID of the Choice in form of an integer

### View a Choice Detail [GET]

+ Response 200 (application/vnd.siren+json)

        {
            "actions": [
                {
                    "name": "vote",
                    "href": "/questions/1/choices/1",
                    "method": "POST"
                }
            ],
            "rel": [ "choice" ],
            "properties": {
                "choice": "Swift",
                "votes": 2048
            },
            "links": [
                {
                    "rel": [ "self" ],
                    "href": "/questions/1/choices/1"
                }
            ]
        }

+ Response 200 (application/hal+json)

        {
            "_links": {
                "self": { "href": "/questions/1/choices/1" }
            },
            "choice": "Swift",
            "votes": 2048
        }

### Vote on a Choice [POST]

This action allows you to vote on a question's choice.

+ Response 201 (application/vnd.siren+json)

        {
            "actions": [
                {
                    "name": "vote",
                    "href": "/questions/1/choices/1",
                    "method": "POST"
                }
            ],
            "rel": [ "choice" ],
            "properties": {
                "choice": "Swift",
                "votes": 2049
            },
            "links": [
                {
                    "rel": [ "self" ],
                    "href": "/questions/1/choices/1"
                }
            ]
        }

+ Response 201 (application/hal+json)

        {
            "_links": {
                "self": "/questions/1/choices/1"
            },
            "choice": "Swift",
            "votes": 2049
        }
