module Trith
  ##
  # The Trith core operators.
  module Core
    require 'trith/vocab/core/execution'
    require 'trith/vocab/core/stack'
    require 'trith/vocab/core/bitwise'
    require 'trith/vocab/core/boolean'
    require 'trith/vocab/core/comparison'
    require 'trith/vocab/core/numeric'
    require 'trith/vocab/core/sequence'
    require 'trith/vocab/core/textual'
    require 'trith/vocab/core/output'

    # Include all submodule methods directly into Trith::Core:
    constants.each { |mod| include(const_get(mod)) }
  end # module Core
end # module Trith
