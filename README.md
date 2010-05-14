Trith is an experimental programming language founded on the [unholy][]
trinity of [Forth][], [Lisp][] and [RDF][] triples.

* <http://trith.org/>

Dependencies
------------

* [Ruby](http://ruby-lang.org/) (>= 1.9.1) or
  [JRuby](http://jruby.org/) (>= 1.4.0)
* [RDF.rb](http://rubygems.org/gems/rdf) (>= 0.1.9)
* [SXP](http://rubygems.org/gems/sxp) (>= 0.0.2)

Installation
------------

The recommended installation method is via [RubyGems](http://rubygems.org/).
To install the latest official release of the `trith` gem, do one of the
following:

    $ [sudo] gem install trith                  # Ruby 1.9+
    $ [sudo] gem1.9 install trith               # Ruby 1.9 with MacPorts
    $ [sudo] jruby --1.9 -S gem install trith   # JRuby 1.4+

Download
--------

To get a local working copy of the development repository, do:

    $ git clone git://github.com/trith/trith.git

Alternatively, you can download the latest development version as a tarball
as follows:

    $ wget http://github.com/trith/trith/tarball/master

Authors
-------

* [Arto Bendiken](mailto:arto.bendiken@gmail.com) - <http://ar.to/>

License
-------

Trith is free and unencumbered public domain software. For more
information, see <http://unlicense.org/> or the accompanying UNLICENSE file.

[Forth]:  http://en.wikipedia.org/wiki/Forth_(programming_language)
[Lisp]:   http://en.wikipedia.org/wiki/Lisp_(programming_language)
[RDF]:    http://en.wikipedia.org/wiki/Resource_Description_Framework
[unholy]: http://lispers.org/
