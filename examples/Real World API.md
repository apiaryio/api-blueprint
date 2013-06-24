FORMAT: X-1A
HOST: https://alpha-api.app.net

# Real World API
This API Blueprint demonstrates a real world example documenting a portion of [App.net API](http://developers.app.net).

NOTE: This document is a **work in progress**.

# Group Posts
This section groups App.net post resources.

## Post [/stream/0/posts/{post_id}]
A Post is the other central object utilized by the App.net Stream API. It has rich text and annotations which comprise all of the content a users sees in their feed. Posts are closely tied to the follow graph...

+ Post Object (application/json)
    
    ```js
    {
        "data": {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
        "meta": {
            "code": 200,
        }
    }
    ```

### Retrieve a Post [GET]
Returns a specific Post.

+ Response 200
    
    [Post][]

### Delete a Post [DELETE]
Delete a Post. The current user must be the same user who created the Post. It returns the deleted Post on success.

+ Response 204
    
    [Post][]

## Posts Collection [/stream/0/posts]
A Collection of posts.

+ Posts Collection Object (application/json)
    
    ```js
    { 
        ["data": {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
        "meta": {
            "code": 200,
        }],
        ...
    }
    ```

### Create a Post [POST]
Create a new Post object. Mentions and hashtags will be parsed out of the post text, as will bare URLs...

+ Request
    
    [Post][]

+ Response 201
    
    [Post][]

### Retrieve all Posts [GET]
Retrieves all posts. 

+ Response 200
    
    [Posts Collection][]

## Stars [/stream/0/posts/{post_id}/star]
A User’s stars are visible to others, but they are not automatically added to your followers’ streams.

### Star a Post [POST]
Save a given Post to the current User’s stars. This is just a “save” action, not a sharing action.

*Note: A repost cannot be starred. Please star the parent Post.*

+ Response 200
    
    [Post][]

### Unstar a Post [DELETE]
Remove a Star from a Post.

+ Response 200
        
    [Post][]
