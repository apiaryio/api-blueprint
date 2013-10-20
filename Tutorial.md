# API Blueprint Tutorial
Welcome to the API Blueprint Tutorial!  

... actually, let's build an API! Let's build an API for our imaginary industry-changing Gist service. 

Gist is a paste. A snippet of text. Not unrelated to [GitHub Gists][].  To set some expectations let's provide following functionality in our API: *List Gists, Retrieve a Single Gist, Create a Gist, Edit a Gist, Star a Gist, Unstar a Gist, Check if a Gist is starred and Delete a Gist.*

For the sake of simplicity we will now omit user management and authentication. These additions to our service will be discussed in a future installment of API Blueprint Tutorial.

## Gist Fox API
Without further ado our *Gist Fox API* blueprint starts like this:

    FORMAT: 1A

    # Gist Fox API
    Gist Fox API is a **pastes service** similar to [GitHub's Gist][http://gist.github.com].

What have we just done? Let's break it line by line:

#### Metadata

    FORMAT: 1A
    
Depending on the tools you will be using with your blueprint you might want to start the blueprint file with a metadata explicitly stating an API Blueprint version. Since this tutorial is for API Blueprint version `1A` the first line 

#### API Name

    # Gist Fox API
    
Every good API should have a name.  So does ours – *"Gist Fox API"*. The first Markdown header in our document represents just that – the API name. 

#### API Description

    Gist Fox API is a **pastes service** similar to [GitHub's Gist][http://gist.github.com].
    
The API Name header might be followed by any arbitrary Markdown-formatted discussion. Preferably about your API.

> **Note:** We will provide much richer description in the final blueprint of our Gist Fox API adding details about **authentication, used media types and error handling**. You will find it in the full listing of the Gist Fox API Blueprint at the end of this tutorial.

> **Note:** Should you need a clarification of some terms as used through this document refer to [API Blueprint Glossary of Terms](Glossary%20of%20Terms.md).

## Markdown
All you really need to write a blueprint is a text editor. A Markdown editor would be even better.  Anything you like. From Vi to Byword. Online editors are great too! Perhaps directly on GitHub in the repository your service will live? 

If you are completely new to Markdown it is now the best time to learn about it. Just head over to [Markdown Tutorial][] and enjoy the ride. Just don't forget to come back we have some cool stuff too! 

Should you just need to refresh Markdown syntax you can always check the one and only [Gruber's Original][].

>  **Note:** It is not essentially required to know the Markdown syntax but it will help a lot. The knowledge of Markdown will make some API Blueprint construct more intuitive.
    
## First Resource
The first resource in our API is its root. The entry point to our API is defined like so:

    # Gist Fox API Root [/]
    Gist Fox API entry point. 

    This resource does not have any attributes. Instead it offers the initial API affordances in the form of the HTTP Link header and HAL links.

    ## Retrieve Entry Point [GET]

    + Response 200 (application/hal+json)
        + Headers
        
                Link: <http:/api.gistfox.com/>;rel="self",<http:/api.gistfox.com/gists>;rel="gists"

        + Body

                {
                    "_links": {
                        "self": { "href": "/" },
                        "gists": { "href": "/gists?{since}", "templated": true }
                    }
                }

What is going on here?

#### Resource

    # Gist Fox API Root [/]

In API Blueprint a resource definition starts with a Markdown header of resource name followed by its URI enclosed in square brackets. The URI is relative to the API root. So in this case it is just `/`.

> **NOTE:** Resource name is an [API Blueprint Identifier][] and as such it can be composed only from a combination of alphanumerical characters, underscores, dashes and a spaces.

#### Resource Description

    # Gist Fox API Root [/]
    Gist Fox API entry point. 

    This resource does not have any attributes. Instead it offers the initial API affordances in the form of the HTTP Link header and haveL links.

As with the API Name the resource name can be followed by an arbitrary Markdown formatted discussion.

#### Action

    ## Retrieve Entry Point [GET]

Here, we have just defined an action named "Retrieve Entry Point" utilizing the `GET` [HTTP Request Method][]. As with the resource and API name we can add any arbitrary discussion here but since the action name is pretty self explanatory lets skip it for now.

#### Response

    + Response 200

In API Blueprint an action **should** always include at least one response that represents the HTTP response message sent back in response to the HTTP request. The response should always bear a [status code][] and possibly an additional [payload][]. We have defined the most common response "200" indicating the request has succeeded.

#### Response Payload

    + Response 200 (application/hal+json)
        + Headers
        
                Link: <http:/api.gistfox.com/>;rel="self",<http:/api.gistfox.com/gists>;rel="gists"

        + Body

                {
                    "_links": {
                        "self": { "href": "/" },
                        "gists": { "href": "/gists?{since}", "templated": true }
                    }
                }

A response usually bear some payload returned to our client. Ideally a representation of the resource in question. In this case our response representation is of the [`application/hal+json`][] media-type. Also in addition to an HTTP response message-body this response defines an HTTP response [message-headers][] in its payload.

> **Note:** API Blueprint is **indentation sensitive**. See the [Note on Indentation][] for details.
>
>  **Note:** Specifying the media type in brackets after the response status codes generates implicit `Content-Type` HTTP header.  That is you don't have to explicitly specify the `Content-Type` header.
>
> **Note:** If your response does not need to define any additional headers (but `Content-Type`) you can skip the `Headers` section completely and write the `Body` section like so:
>               
>        + Response 200 (application/hal+json)
>   
>          {
>              "_links": {
>                  "self": { "href": "/" },
>                  "gists": { "href": "/gists?{since}", "templated": true }
>              }
>          }

## Complex Resource
With the entry point of our API defined we can move forward. Since our API revolves around a Gists lets define its representation and an action to retrieve it:

    # Group Gist
    Gist-related resources of *Gist Fox API*.

    ## Gist [/gists/{id}]
    A single Gist object. The Gist resource is the central resource in the Gist Fox API. It represents one paste - a single text note.

    The Gist resource has the following attributes: 

    - id
    - created_at
    - description
    - content

    The states *id* and *created_at* are assigned by the Gist Fox API at the moment of creation. 


    + Parameters
        + id (string) ... ID of the Gist in the form of a hash.

    + Model (application/hal+json)

        HAL+JSON representation of Gist Resource. In addition to representing its state in the JSON form it offers affordances in the form of the HTTP Link header and HAL links.

        + Headers

                Link: <http:/api.gistfox.com/gists/42>;rel="self", <http:/api.gistfox.com/gists/42/star>;rel="star"

        + Body

                {
                    "_links": {
                        "self": { "href": "/gists/42" },
                        "star": { "href": "/gists/42/star" },
                    },
                    "id": "42",
                    "created_at": "2014-04-14T02:15:15Z",
                    "description": "Description of Gist",
                    "content": "String contents"
                }

    ### Retrieve a Single Gist [GET]
    + Response 200
        
        [Gist][]

Here we have just defined a group of our Gist-related resources. We have also defined a Gist resource, its model representation and an action that retrieves a single Gist. 

Lets break it down to what's new:

#### Groups of Resources

    # Group Gist
    Gist-related resources of *Gist Fox API*.

As our API will eventually provide more resources it is a good practice to group related resources together for better orientation. Here we will be grouping all Gist-related resources under a group simply called *"Gist"*.

#### URI Template

    ## Gist [/gists/{id}]

A variable component of a Gist URI expressed in the form of [URI Template][]. In this case an id of Gist is the variable in its URI expressed as `{id}`. 

<a name="uri_parameter"></a>
#### URI Parameters

    + Parameters
        + id (string) ... ID of the Gist in the form of a hash.

The *"id"* variable of the URI template is a parameter to every action on this resource. Here defined of an arbitrary type `string` and followed by its Markdown-formatted discussion.

> **Note:** You can specify various attributes of an URI parameter. But in its simple form the URI parameter syntax is just the parameter name followed by ellipsis (three dots) and a Markdown-formatted discussion. For example:
>    
>        + Parameters
            + id ... description
> 
> Refer to API Blueprint Specification's [Resource Parameters Section][] for additional examples.

#### Resource Model

    + Model (application/hal+json)

        HAL+JSON representation of Gist Resource. In addition to representing its state in the JSON form it offers affordances in the form of the HTTP Link header and HAL links.

        + Headers

                Link: <http:/api.gistfox.com/gists/42>;rel="self", <http:/api.gistfox.com/gists/42/star>;rel="star"

        + Body

                {
                    "_links": {
                        "self": { "href": "/gists/42" },
                        "star": { "href": "/gists/42/star" },
                    },
                    "id": "42",
                    "created_at": "2014-04-14T02:15:15Z",
                    "description": "Description of Gist",
                    "content": "String contents"
                }
                
Resource Model is an example representation of the Gist resource. We can reference this resource model later at any point where a response (or request) payload is expected. A resource model has *exactly* the same sections as a response payload. In this case it also includes additional description. 

A Resource Model may not include a response status code.

####  Referring the Resource Model

    ### Retrieve a Single Gist [GET]
    + Response 200
        
        [Gist][]
        
With Gist Resource Model in place it is super easy to define an action that retrieves a single gist. 

> **NOTE:** The syntax for referring a resource model is `[<resource identifier>][]`.  You can only refer to already defined models. The model must be referred as "whole".  You can't reuse just a model's body or headers.

## Modifying a Resource
Let's add an action to our Gist Resource that will modify its state and another action that deletes a Gist Resource as whole.

    ### Edit a Gist [PATCH]
    To update a Gist send a JSON with updated value for one or more of the Gist resource attributes. All attributes values (states) from the previous version of this Gist are carried over by default if not included in the hash.

    + Request (application/json)

            {
                "content": "Updated file contents"
            }

    + Response 200
        
        [Gist][]

    ### Delete a Gist [DELETE]
    + Response 204
        
Here are few new things to learn about payloads:

#### Request and its Payload

    + Request (application/json)

            {
                "content": "Updated file contents"
            }

Our "Edit a Gist" action needs to receive some input data to update the state of the Gist resource with it. The data are part of an HTTP request message. This section defines such a Request and an example [payload][] of the request message.

> **NOTE:** The Request follows exactly the same structure as a Response or Model. As with the Resource Model a Request may not include a response status code.

#### Empty Payload

    ### Delete a Gist [DELETE]
    + Response 204

In the case of the "Delete a Gist" action our response bears status code "204" indicating the server has successfully fulfilled the request and that there is no additional content to send in the response payload body. There is no additional payload specified for this response.

## Collection Resource
Let's define a collection for our Gist Resources:

    ## Gists Collection [/gists{?since}]
    Collection of all Gists.

    The Gist Collection resource has the following attribute:

    - total

    In addition it **embeds** *Gist Resources* in the Gist Fox API.


    + Model (application/hal+json)

        HAL+JSON representation of Gist Collection Resource. The Gist resources in collections are embedded. Note the embedded Gists resource are incomplete representations of the Gist in question. Use the respective Gist link to retrieve its full representation.

        + Headers

                Link: <http:/api.gistfox.com/gists>;rel="self"

        + Body

                {
                    "_links": {
                        "self": { "href": "/gists" }
                    },
                    "_embedded": {
                        "gists": [
                            {
                                "_links" : {
                                    "self": { "href": "/gists/42" }
                                },
                                "id": "42",
                                "created_at": "2014-04-14T02:15:15Z",
                                "description": "Description of Gist"
                            }
                        ]
                    },
                    "total": 1
                }

    ### List All Gists [GET]
    + Parameters
        + since (optional, string) ... Timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ Only Gists updated at or after this time are returned.

    + Response 200

        [Gists Collection][]

    ### Create a Gist [POST]
    To create a new Gist simply provide a JSON hash of the *description* and *content* attributes for the new Gist. 

    + Request (application/json)

            {
                "description": "Description of Gist",
                "content": "String content"
            }

    + Response 201 (application/hal+json)

        [Gist][]

Not much new here except the definition and discussion of query parameter *"since"*: 

#### Query Parameters

    ## Gists Collection [/gists{?since}]

As with the URI Parameters the query parameters are defined in the [URI Template][]. The diferrence here is that a query parameter name is preceeded by the questionmark and its definition is always at the end of the URI Template.

> **NOTE:** To define multiple query parameters simply comma-separate their names. For example `{?since,month,year}`. 

#### Action-specific Query Parameters

    ### List All Gists [GET]
    + Parameters
        + since (optional, string) ... Timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ Only Gists updated at or after this time are returned.

Often a resource query parameters are specific to just one of the resource actions. In this case you can discuss it in the relevant action only using the same syntax as with [URI Parameters][].

## Reach to the Stars 
The last missing piece in the expected functionality is to add the Star Resource and actions to retrieve and manipulate its starred state.

    ## Star [/gists/{id}/star]
    Star resource represents a Gist starred status. 

    The Star resource has the following attribute:

    - starred


    + Parameters

        + id (string) ... ID of the gist in the form of a hash

    + Model (application/hal+json)

        HAL+JSON representation of Star Resource.

        + Headers

                Link: <http:/api.gistfox.com/gists/42/star>;rel="self"

        + Body

                {
                    "_links": {
                        "self": { "href": "/gists/42/star" },
                    },
                    "starred": true
                }

    ### Star a Gist [PUT]
    + Response 204

    ### Unstar a Gist [DELETE]
    + Response 204

    ### Check if a Gist is Starred [GET]
    + Response 200

        [Star][]

## Complete Blueprint
You can find the complete Gist Fox API blueprint [full listing][] in the [API Blueprint Examples][] repository.

## API Blueprint Tools
With Gist Fox Blueprint completed it is time to put it at work. For start, you can browse this API [rendered by GitHub][] or enjoy it [rendered by Apiary][]. 

Visit the [Tooling Section][] of the [apiblueprint.org][] to find about other tools you can use with your blueprint. 

---

<a name="indentation"></a>
### Note on Indentation
In API Blueprint payload assets are represented by [Markdown pre-formatted code blocks][]. That means **an asset has to be indented by four spaces** relative to its level. In the case of Markdown list items, which are also by definition indented, it is even one more level further making it a total of **eight spaces** or whopping twelve spaces for list items nested under another list item. 

For example the asset in `Body` list item which is nested under the `Response 200` item is indented by twelve spaces.

You can save one level of indentation using the [GitHub-flavored Markdown][] syntax for [fenced code blocks][]:

    + Response 200 (application/hal+json)
        + Headers
            ```
            Link: <http:/api.gistfox.com/>;rel="self",<http:/api.gistfox.com/gists>;rel="gists"
            ```
        + Body
            ```
            {
              "_links": {
                  "self": { "href": "/" },
                  "gists": { "href": "/gists?{since}", "templated": true }
              }
            }
            ```

[GitHub Gists]: https://gist.github.com
[Markdown Tutorial]: http://www.markdowntutorial.com
[Gruber's Original]: http://daringfireball.net/projects/markdown/syntax
[HTTP Request Method]: https://github.com/for-GET/know-your-http-well/blob/master/methods.md
[status code]: https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md
[message-headers]: https://github.com/for-GET/know-your-http-well/blob/master/headers.md
[`application/hal+json`]: https://github.com/mikekelly/hal_specification
[Markdown pre-formatted code blocks]: http://daringfireball.net/projects/markdown/syntax#precode
[GitHub-flavored Markdown]: https://help.github.com/articles/github-flavored-markdown
[fenced code blocks]:https://help.github.com/articles/github-flavored-markdown#fenced-code-blocks
[URI Template]: Glossary%20of%20Terms.md#uri-template
[Resource Parameters Section]: API%20Blueprint%20Specification.md#ResourceParametersSection
[payload]: Glossary%20of%20Terms.md#payload
[API Blueprint Identifier]: https://github.com/apiaryio/api-blueprint/blob/1A/API%20Blueprint%20Specification.md#Identifiers
[URI Parameters]: #uri_parameter
[Note on Indentation]: #indentation
[API Blueprint Examples]: https://github.com/apiaryio/api-blueprint/tree/master/examples
[full listing]: https://raw.github.com/apiaryio/api-blueprint/master/examples/Gist%20Fox%20API.md
[rendered by GitHub]: examples/Gist%20Fox%20API.md
[rendered by Apiary]: http://docs.gistfoxapi.apiary.io
[Tooling Section]: http://apiblueprint.org/#tooling
[apiblueprint.org]: http://apiblueprint.org