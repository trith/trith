module Trith; module Core
  ##
  # Bitwise operators.
  #
  # @see http://en.wikipedia.org/wiki/Bitwise_operation
  module Bitwise
    ##
    # @param  [Integer] a
    # @return [Integer]
    def not(a)
      ~a
    end

    ##
    # @param  [Integer] a
    # @param  [Integer] b
    # @return [Integer]
    def and(a, b)
      a & b
    end

    ##
    # @param  [Integer] a
    # @param  [Integer] b
    # @return [Integer]
    def or(a, b)
      a | b
    end

    ##
    # @param  [Integer] a
    # @param  [Integer] b
    # @return [Integer]
    def xor(a, b)
      a ^ b
    end

    ##
    # @param  [Integer] a
    # @param  [Integer] b
    # @return [Integer]
    def shl(a, b)
      a << b
    end

    ##
    # @param  [Integer] a
    # @param  [Integer] b
    # @return [Integer]
    def shr(a, b)
      a >> b
    end
  end # module Bitwise
end; end # module Trith::Core
