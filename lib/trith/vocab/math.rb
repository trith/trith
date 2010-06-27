module Trith
  ##
  # The Trith math operators.
  #
  # @see http://ruby-doc.org/core/classes/Math.html
  module Math
    require 'trith/vocab/math/arithmetic'
    require 'trith/vocab/math/constants'
    require 'trith/vocab/math/operators'
    require 'trith/vocab/math/trigonometry'

    # Include all submodule methods directly into Trith::Math:
    constants.each { |mod| include(const_get(mod)) }
  end # module Math
end # module Trith
