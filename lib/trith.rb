require 'digest/sha1'
require 'rdf'
require 'rdf/ntriples'
require 'rdf/nquads'

module Trith
  autoload :Cache,    'trith/cache'
  autoload :Function, 'trith/function'
  autoload :Shell,    'trith/shell'
  autoload :VERSION,  'trith/version'
end
