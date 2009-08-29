require 'uri'
require 'trith/version'

unless defined?(SXP)
  autoload :SXP, 'sxp'
end

unless defined?(Machinery)
  autoload :Machinery, 'machinery'
end

module Trith
  autoload :Compiler,    'trith/compiler'
  autoload :Instruction, 'trith/instruction'
  autoload :Machine,     'trith/machine'
  autoload :Optimizer,   'trith/optimizer'
  autoload :Program,     'trith/program'
  autoload :Reader,      'trith/reader'
end
