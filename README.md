ActiveTriple: a tool to search a triple store
=============================================

To search for items: 

near a given location:

    ActiveTriple.location('London')

within 30km of a location

    ActiveTriple.location('London', '30km')

about a resource

    ActiveTriple.about('London')

mentions a resource

    ActiveTriple.mentions('London')

with a title of "This article"

    ActiveTriple.title('This article')

Using where
-----------

The title query can also be made using a where clause, with the key matching
the predicate, and the value matching the object. The where method accepts
both colon delimited style triples and bracketed url style triples 

    ActiveTriple.where('dc:terms:title' => 'text:en:"This article"')

or

    ActiveTriple.where('<http://purl.org/dc/terms/title>' => '"This article"@en')

Combining queries
-----------------

    ActiveTriple.location('Evesham', '200km').mentions('London')

Limiting queries
----------------
By default, queries are limited to return ten items. This can be overwritten.

    ActiveTriple.location('London').limit(2)
    ActiveTriple.limit(20).location('London')

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

    ActiveTriple.mentions('XXXXYYYY').all  ---> []

