module Trith; module Core
  ##
  # Math operators.
  #
  # @see http://ruby-doc.org/core/classes/Math.html
  module Math
    ##
    # Math constants.
    module Constants
      # TODO
    end # module Constants

    ##
    # Math operators.
    module Operators
      ##
      # @param  [Numeric, #ceil] n
      # @return [Integer]
      def ceil(n)
        n.ceil
      end

      ##
      # @param  [Numeric, #floor] n
      # @return [Integer]
      def floor(n)
        n.floor
      end
    end # module Operators

    # Include all submodule methods directly into Trith::Core::Math:
    constants.each { |mod| include(const_get(mod)) }
  end # module Math
end; end # module Trith::Core
