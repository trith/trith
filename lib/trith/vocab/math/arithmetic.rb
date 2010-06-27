module Trith; module Math
  ##
  # Arithmetic operators.
  #
  # @see http://www.math.bas.bg/bantchev/articles/divmod.pdf
  module Arithmetic
    ##
    # @param  [Numeric] n
    # @return [Numeric]
    def abs(n)
      n.abs
    end

    ##
    # @param  [Numeric] n
    # @return [Numeric]
    def neg(n)
      -n
    end

    ##
    # @param  [Numeric] n
    # @return [Numeric]
    def inc(n)
      n + 1
    end

    ##
    # @param  [Numeric] n
    # @return [Numeric]
    def dec(n)
      n - 1
    end

    ##
    # @param  [Numeric] a
    # @param  [Numeric] b
    # @return [Numeric]
    def add(a, b)
      a + b
    end
    alias_method :+, :add

    ##
    # @param  [Numeric] a
    # @param  [Numeric] b
    # @return [Numeric]
    def sub(a, b)
      a - b
    end
    alias_method :-, :sub

    ##
    # @param  [Numeric] a
    # @param  [Numeric] b
    # @return [Numeric]
    def mul(a, b)
      a * b
    end
    alias_method :*, :mul

    ##
    # @param  [Numeric] a
    # @param  [Numeric] b
    # @return [Numeric]
    def div(a, b)
      a / b
    end
    alias_method :'/', :div

    ##
    # @param  [Numeric] a
    # @param  [Numeric] b
    # @return [Numeric]
    def rem(a, b)
      a.remainder(b)
    end

    ##
    # @param  [Numeric] a
    # @param  [Numeric] b
    # @return [Numeric]
    def mod(a, b)
      a.modulo(b)
    end
    #alias_method :'%', :mod

    ##
    # @param  [Numeric] a
    # @param  [Numeric] b
    # @return [Numeric]
    def pow(a, b)
      a ** b
    end
    #alias_method :'^', :pow
  end # module Arithmetic
end; end # module Trith::Math
