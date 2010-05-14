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
    def drop2
      pop(2)
      self
    end
    alias_method :'2drop', :drop2

    ##
    # @return [Machine]
    def drop3
      pop(3)
      self
    end
    alias_method :'3drop', :drop3

    ##
    # @return [Machine]
    def nip
      push(pop(2).last)
    end

    ##
    # @return [Machine]
    def nip2
      push(pop(3).last)
    end
    alias_method :'2nip', :nip2

    ##
    # @return [Machine]
    def dup
      push(*(pop(1) * 2))
    end

    ##
    # @return [Machine]
    def dup2
      push(*(pop(2) * 2))
    end
    alias_method :'2dup', :dup2

    ##
    # @return [Machine]
    def dup3
      push(*(pop(3) * 2))
    end
    alias_method :'3dup', :dup3

    ##
    # @return [Machine]
    def swap
      push(*pop(2).reverse)
    end

    ##
    # @return [Machine]
    def over
      push(*((ops = pop(2)) + [ops.first]))
    end

    ##
    # @return [Machine]
    def pick
      push(*((ops = pop(3)) + [ops.first]))
    end

    ##
    # @return [Machine]
    def dip
      # TODO
    end
  end # module Shuffling
end; end # module Trith::Core
