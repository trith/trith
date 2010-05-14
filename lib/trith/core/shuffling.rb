module Trith; module Core
  ##
  # Stack shuffling operators.
  module Shuffling
    ##
    # @return [Machine]
    def reset
      stack.clear
      self
    end

    ##
    # @return [Machine]
    def drop
      pop
      self
    end

    ##
    # @return [Machine]
    def dup
      push(peek, pop)
    end

    ##
    # @return [Machine]
    def swap
      push(*pop(2).reverse)
    end

    ##
    # @return [Machine]
    def dip
      # TODO
    end
  end # module Shuffling
end; end # module Trith::Core
