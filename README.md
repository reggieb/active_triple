ActiveTriple: a tool to search a triple store
=============================================

Configuration
-------------
Before you can use ActiveTriple, you must set up a connector and
associate it with ActiveTriple.

    ActiveTriple.set_connector(MyConnector)

Two connector templates are provided:

ActiveTriple::Connectors::TripleStoreConnector
---------------------------------------------

A very basic connector, that shows the minimum requirement for a connector.

ActiveTriple::Connectors::PostToUrlConnector
----------------------------------------------
This connector provides a connection to a server via HTTP post. If you have
a server that will return json data to a posted request, you can inherit
from this class to make a simple connector. For example:

    class MyConnector < ActiveTriple::Connectors::PostToUrlConnector
      def path
        @path = 'http://path/to/the/server'
      end
    end

    ActiveTriple.set_connector MyConnector


Usage
-----

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

    ActiveTriple.location('London').collect{|a| a.title}

Items returned as objects
-------------------------

Notice in the last example, that the item is an object with a method title.
Hashie is used to convert the data from it's native hash to an object. The
native hash is nested and this is reflected in the structure of the object.

To return the body text of the first item:

    ActiveTriple.location('London').first.full_data.body

To return the original hash:

    ActiveTriple.location('London').first.to_hash

No items found
--------------
If the query returns no items, an empty array will be returned when an attempt
is made to access the data.

    ActiveTriple.mentions('XXXXYYYY').all  ---> []

