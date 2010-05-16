require 'bigdecimal'
require 'rational'
require 'digest/sha1'
require 'rdf'
require 'rdf/ntriples'
require 'rdf/nquads'
require 'sxp'

module Trith
  include RDF

  autoload :Cache,    'trith/cache'
  autoload :Compiler, 'trith/compiler'
  autoload :Core,     'trith/core'
  autoload :Function, 'trith/function'
  autoload :Machine,  'trith/machine'
  autoload :Reader,   'trith/reader'
  autoload :Shell,    'trith/shell'
  autoload :VERSION,  'trith/version'
end
