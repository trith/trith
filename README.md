Trith: Recombinant Programming
==============================

Trith is an experimental [concatenative][concat.org] programming language
founded on the [unholy][lispers.org] trinity of [Forth][], [Lisp][] and
[RDF][] triples.

* <http://trith.org/>
* <http://github.com/trith/trith>

Description
-----------

Trith is a stack-based, concatenative, dynamically-typed functional
programming language with a homoiconic program representation.

* [Stack-based][stack-oriented] means that instead of having named
  parameters, Trith functions operate on an implicit data structure called
  the _operand stack_. Trith functions can be thought of in terms of popping
  and pushing operands from/onto this stack, or equivalently in purely
  functional terms as unary functions that map from one stack to another.
* [Concatenative][concatenative] means that the concatenation of any two
  Trith functions also denotes the [composition][] of those functions.
* [Dynamically typed][type system] means that operands to Trith functions
  are type-checked dynamically at runtime.
* [Homoiconic][homoiconic] means that in Trith there is no difference
  between code and data. You can manipulate and construct code at runtime as
  easily as you would manipulate any other data structure, enabling powerful
  metaprogramming facilities. Trith programs are simply nested lists
  of operators and operands, and can be represented externally either as
  [S-expressions][S-expression] or as [RDF][] triples.

Trith is inspired and influenced by experience with [Forth][], [Lisp][] and
[Scheme][] in general, and the concatenative languages [Joy][], [XY][],
[Factor][] and [Cat][] in particular.

Introduction
------------

The Trith implementation currently consists of a virtual machine,
interpreter, and compiler toolchain written in Ruby and an in-the-works
runtime targeting the [JVM][].

You can use the Trith shell `3sh` to explore Trith interactively:

    $ 3sh
    >> "Hello, world!" print
    Hello, world!

For example, here's how you would start with two prime numbers and end up
with the correct answer to the ultimate question of life, the universe, and
everything:

    $ 3sh
    >> 3 7 swap dup + *
    => [42] : []

In the above `3sh` examples, `>>` indicates lines that you type, and `=>`
indicates the result from the shell.  After each input line is evaluated,
the shell will show you the current state of the Trith virtual machine's
data stack and code queue.

Thus in our previous example, the `[42]` on the left-hand side shows that
the machine's stack contains a single operand, the number 42. The `[]` on
the right-hand side shows that the machine's code queue is empty, which is
generally the case after all input has been successfully evaluated.

Let's run through the above example one more time using the `--debug` option
to `3sh`, which enables the tracing of each queue reduction step in the
virtual machine:

    $ 3sh --debug
    >> 3 7 swap dup + *
    ..      [] : [3 7 swap dup + *]
    ..     [3] : [7 swap dup + *]
    ..   [3 7] : [swap dup + *]
    ..   [7 3] : [dup + *]
    .. [7 3 3] : [+ *]
    ..   [7 6] : [*]
    =>    [42] : []

As you can see, the virtual machine starts execution with an empty operand
stack on the left-hand side and with all input placed onto the operator
queue on the right-hand side. When input operands such as numbers are
encountered on the queue, they are simply pushed onto the stack, which grows
from left to right. When an operator such as the multiplication operator
`*` is encountered on the queue, it is executed. Operators pop operands
from the stack and then push their result(s) back onto the stack.

When fooling around in the Trith shell, two useful operators to know are
`clear`, which clears the stack, and `halt`, which clears the queue (thus
halting execution). You can also use `reset` which does both in one step,
returning you to a guaranteed clean slate.

To get a listing of all operators supported in the current release, enter
the `?` metacommand in the Trith shell.

Linked Code
-----------

All Trith operators are identified by URIs, meaning that Trith code can be
straightforwardly represented as [Linked Data][]. Here's an example of the
`abs` operator defined metacircularly using the Turtle serialization format
for RDF data:

    @base          <http://trith.org/core/> .
    @prefix trith: <http://trith.org/lang/> .
    @prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> .

    <abs> a trith:Function ;
      rdfs:label     "abs" ;
      rdfs:comment   "Returns the absolute value of a number."@en ;
      trith:arity    1 ;
      trith:code     (<dup> 0 <lt> (<neg>) (<nop>) <branch>) .

This function description comprises a total of 21 triples. The entire Trith
core library currently weighs in at about a kilotriple (1,000 triples), with
all but a handful of primitive (irreducible) operators having a metacircular
definition. See `etc/trith-core.ttl` for the RDF definitions of Trith core
operators.

Reference
---------

### Sequences

Trith has a rich set of sequence operators that will be instantly familiar
to programmers coming from functional programming languages such as Scheme,
Clojure or Haskell:

    >> 10 iota
    => [[0 1 2 3 4 5 6 7 8 9]] : []
    >> dup seq? .
    true
    >> dup empty? .
    false
    >> dup length .
    10
    >> [dup mul] map
    => [[0 1 4 9 16 25 36 49 64 81]] : []
    >> dup first .
    0
    >> dup fifth .
    16
    >> dup 7 nth .
    49
    >> dup last .
    81
    >> dup 0 [+] foldl .
    285
    >> rest
    => [[1 4 9 16 25 36 49 64 81]] : []
    >> dup 1 [*] foldl .
    131681894400
    >> reverse
    => [[81 64 49 36 25 16 9 4 1]] : []

### Strings

Strings are simply sequences of characters (Unicode code points), meaning
that you can make use of any of the normal sequence operators on strings as
well:

    >> : hello "Hello," " world!" concat ;
    >> hello seq? .
    true
    >> hello text? .
    true
    >> hello empty? .
    false
    >> hello length .
    13
    >> hello first .
    H
    >> hello rest .
    ello, world!
    >> hello reverse .
    !dlrow ,olleH

Scripting
---------

The canonical "Hello, world!" script is found in `doc/examples/hello.3th`:

    #!/usr/bin/env 3vm
    "Hello, world!" print

Any command-line arguments passed to 3VM scripts form the initial stack of
the virtual machine. The arguments are placed on the stack in their original
unparsed string form.

You can print out the contents of the initial stack like so:

    #!/usr/bin/env 3vm
    stack print

Here's an example of how you would interpret all given command-line
arguments as numbers and then sum them up and print out the result:

    #!/usr/bin/env 3vm
    stack [num] map 0 [+] foldl print

Embedding
---------

### Embedding Trith in Ruby

    require 'trith'

    # Let's start with the obligatory  "Hello, world!" example:

    Trith::Machine.run do
      push "Hello, world!"
      print
    end

    # There are several equivalent ways to execute Trith code:

    Trith::Machine.run { push(6, 7).mul }            #=> 42
    Trith::Machine.run [6, 7] { mul }                #=> 42
    Trith::Machine.run [6, 7, :mul]                  #=> 42

    # Operators in Ruby blocks can be chained together:

    Trith::Machine.run { push(2).dup.dup.mul.pow }   #=> 16

    # If you require more control, instantiate a machine manually:

    vm = Trith::Machine.new
    vm.define!(:square) { dup.mul }
    vm.push(10).square.peek                          #=> 100

    # You can also define operators when constructing a machine:

    vm = Trith::Machine.new(data = [], code = [], {
      :hello => proc { push("Hello, world!").print },
    })

    # Should you want to use any Trith functions from Ruby, it's easy enough
    # to encapsulate a virtual machine inside a Ruby method:

    def square(n)
      Trith::Machine.run [n] { dup.mul }
    end

    square(10)                                       #=> 100

### Embedding Trith in JVM-based languages

The [JVM][] runtime for Trith is a work in progress. See `src/java` for the
runtime's source code and current status.

Dependencies
------------

* [Ruby](http://ruby-lang.org/) (>= 1.9.1) or
  (>= 1.8.2 with [Backports](http://rubygems.org/gems/backports))
* [RDF.rb](http://rubygems.org/gems/rdf) (>= 0.1.10)
* [SXP](http://rubygems.org/gems/sxp) (>= 0.0.4)
* [Promise](http://rubygems.org/gems/promise) (>= 0.1.1)

Installation
------------

The recommended installation method is via [RubyGems](http://rubygems.org/).
To install the latest official release of the `trith` gem, do one of the
following:

    $ [sudo] gem install trith                  # Ruby 1.8.x/1.9.x
    $ [sudo] gem1.9 install trith               # Ruby 1.9 with MacPorts
    $ [sudo] jruby --1.9 -S gem install trith   # JRuby 1.5+

Once Trith is installed, you will have four new programs available:

* `3sh`, aka "trish", is the Trith interactive shell and interpreter.
* `3vm`, aka "trivium", is the Trith virtual machine runtime.
* `3cc`, aka "tricksy", is the Trith compiler.
* `3th`, aka "trith", is the Trith package manager.

Note that as of the current release, only the first two do anything much as
yet.

Environment
-----------

The following are the default settings for environment variables that let
you customize how Trith works:

    $ export TRITH_HOME=~/.trith
    $ export TRITH_CACHE=$TRITH_HOME/cache
    $ export TRITH_TERM=$TERM

Download
--------

To get a local working copy of the development repository, do:

    $ git clone git://github.com/trith/trith.git

Alternatively, you can download the latest development version as a tarball
as follows:

    $ wget http://github.com/trith/trith/tarball/master

Mailing List
------------

* <http://groups.google.com/group/trith>

Authors
-------

* [Arto Bendiken](mailto:arto.bendiken@gmail.com) - <http://ar.to/>

License
-------

Trith is free and unencumbered public domain software. For more
information, see <http://unlicense.org/> or the accompanying UNLICENSE file.

[stack-oriented]: http://en.wikipedia.org/wiki/Stack-oriented_programming_language
[concatenative]:  http://en.wikipedia.org/wiki/Concatenative_programming_language
[composition]:    http://en.wikipedia.org/wiki/Function_composition
[type system]:    http://en.wikipedia.org/wiki/Type_system#Dynamic_typing
[homoiconic]:     http://en.wikipedia.org/wiki/Homoiconicity
[S-expression]:   http://en.wikipedia.org/wiki/S-expression
[RDF]:            http://en.wikipedia.org/wiki/Resource_Description_Framework
[JVM]:            http://en.wikipedia.org/wiki/Java_Virtual_Machine
[Lisp]:           http://en.wikipedia.org/wiki/Lisp_(programming_language)
[Scheme]:         http://en.wikipedia.org/wiki/Scheme_(programming_language)
[Forth]:          http://en.wikipedia.org/wiki/Forth_(programming_language)
[Factor]:         http://en.wikipedia.org/wiki/Factor_(programming_language)
[Joy]:            http://en.wikipedia.org/wiki/Joy_(programming_language)
[Cat]:            http://en.wikipedia.org/wiki/Cat_(programming_language)
[XY]:             http://www.nsl.com/k/xy/xy.htm
[Linked Data]:    http://linkeddata.org/
[lispers.org]:    http://lispers.org/
[concat.org]:     http://concatenative.org/wiki/view/Concatenative%20language
