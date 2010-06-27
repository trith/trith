module Trith; module Core
  ##
  # Comparison operators.
  #
  # @see http://ruby-doc.org/core-1.9/classes/Comparable.html
  # @see http://en.wikipedia.org/wiki/Comparison_(computer_programming)
  # @see http://en.wikipedia.org/wiki/Relational_operator
  module Comparison
    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Integer]
    def cmp(a, b)
      a <=> b
    end
    alias_method :<=>, :cmp

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Boolean]
    def eq(a, b)
      a == b
    end
    alias_method :'=', :eq

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Boolean]
    def ne(a, b)
      a != b
    end
    alias_method :'!=', :ne

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Boolean]
    def lt(a, b)
      a < b
    end
    alias_method :<, :lt

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Boolean]
    def le(a, b)
      a <= b
    end
    alias_method :<=, :le

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Boolean]
    def gt(a, b)
      a > b
    end
    alias_method :>, :gt

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Boolean]
    def ge(a, b)
      a >= b
    end
    alias_method :>=, :ge

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Object]
    def min(a, b)
      [a, b].min
    end

    ##
    # @param  [Object] a
    # @param  [Object] b
    # @return [Object]
    def max(a, b)
      [a, b].max
    end
  end # module Comparison
end; end # module Trith::Core
