# API Blueprint Tutorial
Welcome to the API Blueprint Tutorial!  

... actually, let's build an API! Let's build an API for our imaginary industry-changing Gist service. 

Gist is a paste. A snippet of text. Not unrelated to [GitHub Gists][].  To set some expectations let's provide following functionality in our API: *List Gists, Retrieve a Single Gist, Create a Gist, Edit a Gist, Star a Gist, Unstar a Gist, Check if a Gist is starred and Delete a Gist.*

For the sake of simplicity we will now omit user management and authentication. These additions to our service will be discussed in a future installment of API Blueprint Tutorial.

---

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

#### Resource:

	# Gist Fox API Root [/]

In API Blueprint a resource definition starts with a Markdown header of resource name followed by its URI enclosed in square brackets. The URI is relative to the API root. So in this case it is just `/`.

#### Resource Description

	# Gist Fox API Root [/]
	Gist Fox API entry point. 

As with the API Name the resource name can be followed by an arbitrary Markdown formatted discussion:

#### Action

	## Retrieve Entry Point [GET]

Here, we have just defined an action named "Retrieve Entry Point" utilizing the `GET` [HTTP Request Method][]. As with the resource and API name we can add an arbitrary discussion but since the action name is pretty self explanatory lets skip it for now.

#### Response

	+ Response 200

In API Blueprint an action **should** always include at least one response that represents the HTTP response message sent back in response to the HTTP request. The response should always bear a [status code][] and possibly an additional payload. Since we are [happy-case][] programmers we have defined a response "200" indicating the request has succeeded.

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

A response usually bear some payload returned to our client. Ideally a representation of the resource in question. Our response representation is of the [`application/hal+json`][] media-type. Also in addition to an HTTP response message-body this response also define a HTTP response [message-headers][].

> **Note:** API Blueprint is indentation sensitive. Refer to [Note on Indentation](#indentation) for details.
>
>  **Note:** Specifying the media type in brackets after the response status codes generates implicit `Content-Type` HTTP header.  That is you don't have to explicitly specify the `Content-Type` header.
>
> **Note:** If your response does not need to define any additional headers but `Content-Type` you can skip the `Headers` section completely and write the `Body` section like so:
>		        
>        + Response 200 (application/hal+json)
>   
>          {
>              "_links": {
>                  "self": { "href": "/" },
>                  "gists": { "href": "/gists?{since}", "templated": true }
>              }
>          }

## Groups of Resources
Our API will eventually provide some resources. While not strictly necessary it is a good practice to group related resources together for better orientation 

TODO:

<a name="indentation"></a>
## Note on Indentation
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

---

[GitHub Gists]: https://gist.github.com
[Markdown Tutorial]: http://www.markdowntutorial.com
[Gruber's Original]: http://daringfireball.net/projects/markdown/syntax
[HTTP Request Method]: https://github.com/for-GET/know-your-http-well/blob/master/methods.md
[status code]: https://github.com/for-GET/know-your-http-well/blob/master/status-codes.md
[happy-case]: http://en.wikipedia.org/wiki/Happy_path
[message-headers]: https://github.com/for-GET/know-your-http-well/blob/master/headers.md
[`application/hal+json`]: https://github.com/mikekelly/hal_specification
[Markdown pre-formatted code blocks]: http://daringfireball.net/projects/markdown/syntax#precode
[GitHub-flavored Markdown]: https://help.github.com/articles/github-flavored-markdown
[fenced code blocks]:https://help.github.com/articles/github-flavored-markdown#fenced-code-blocks
