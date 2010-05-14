module Trith
  ##
  # The Trith core operators.
  module Core
    require 'trith/core/execution'
    require 'trith/core/shuffling'
    require 'trith/core/boolean'
    require 'trith/core/numeric'
    require 'trith/core/arithmetic'
    require 'trith/core/bitwise'
    require 'trith/core/comparison'
    require 'trith/core/sequence'
    require 'trith/core/textual'

    # Include all submodule methods directly into Trith::Core:
    constants.each { |mod| include(const_get(mod)) }
  end # module Core
end # module Trith
