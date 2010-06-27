module Trith; module Math
  ##
  # Math operators.
  #
  # @see http://ruby-doc.org/core/classes/Math.html
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
end; end # module Trith::Math
