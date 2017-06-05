FORMAT: 1A

# Grouping Resources API
This API example demonstrates how to group resources and form **groups of
resources**. You can create as many or as few groups as you like. If you do not
create any group all your resources will be part of an "unnamed" group.

## API Blueprint
+ [Previous: Named Resource and Actions](03.%20Named%20Resource%20and%20Actions.md)
+ [This: Raw API Blueprint](https://raw.github.com/apiaryio/api-blueprint/master/examples/04.%20Grouping%20Resources.md)
+ [Next: Responses](05.%20Responses.md)

# Group Messages
Group of all messages-related resources.

This is the first group of resources in this document. It is **recognized** by
the **keyword `group`** and its name is `Messages`.

Any following resource definition is considered to be a part of this group
until another group is defined. It is **customary** to increase header level of
resources (and actions) nested under a resource.

## My Message [/message]

### Retrieve a Message [GET]

+ Response 200 (text/plain)

        Hello World!

### Update a Message [PUT]

+ Request (text/plain)

        All your base are belong to us.

+ Response 204

# Group Users
Group of all user-related resources.

This is the second group in this blueprint. For now, no resources were defined
here and as such we will omit it from the next installment of this course.
