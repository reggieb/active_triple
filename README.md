ActiveTriple: a tool to search a triple store
=============================================

To search for items: 

near a given location:

    ActiveTriple.location('London')

within 30km of a location

    ActiveTriple.location('London', '30km').all

with a title of "This article"

    ActiveTriple.title('This article')

or

    ActiveTriple.where('dc:terms:title' => "text:en:\"This article\"")

about a resource

    ActiveTriple.about('London')

mentions a resource

    ActiveTriple.mentions('London')

Combining queries
-----------------

    ActiveTriple.location('Evesham', '200km').mentions('London')

Limiting queries
----------------
By default, queries are limited to return ten items. This can be overwritten.

    ActiveTriple.location('London').limit(2)
    ActiveTriple.location('London').limit(20)

Accessing the data
------------------

    Each of the above searches will return an ActiveTriple instance. To access
the data returned by the query, either use 'all' or use an Array method.

Get all the items:

    ActiveTriple.location('London').all

Get the title of each of the items:

    ActiveTriple.location('London').collect{|a| a['title']}

No items found
--------------
If the query returns no items, an empty array will be returned when an attempt
is made to access the data.

