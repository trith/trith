module Trith; module Core
  ##
  # Numerical operators.
  #
  # @see http://ruby-doc.org/core-1.9/classes/Numeric.html
  # @see http://ruby-doc.org/core-1.9/classes/Integer.html
  # @see http://ruby-doc.org/core-1.9/classes/Rational.html
  # @see http://ruby-doc.org/core-1.9/classes/Float.html
  module Numeric
    ##
    # @param  [Object]  obj
    # @return [Numeric]
    def number(obj)
      case obj
        when Numeric then obj
        else obj.to_i # FIXME
      end
    end

    ##
    # @param  [Object]  obj
    # @return [Boolean]
    def numberp(obj)
      obj.is_a?(Numeric)
    end
    alias_method :number?, :numberp

    ##
    # @param  [Object]  obj
    # @return [Boolean]
    def integerp(obj)
      obj.is_a?(Integer)
    end
    alias_method :integer?, :integerp

    ##
    # @param  [Numeric, #exact?] n
    # @return [Boolean]
    def exactp(n)
      case n
        when Integer  then true
        when Rational then true
        when Float    then false
        else case
          when n.respond_to?(:exact?)
            n.exact?
          else nil
        end
      end
    end
    alias_method :exact?, :exactp

    ##
    # @param  [Numeric, #inexact?] n
    # @return [Boolean]
    def inexactp(n)
      case n
        when Integer  then false
        when Rational then false
        when Float    then true
        else case
          when n.respond_to?(:inexact?)
            n.inexact?
          else nil
        end
      end
    end
    alias_method :inexact?, :inexactp

    ##
    # @param  [Numeric, #zero?] n
    # @return [Boolean]
    def zerop(n)
      n.zero?
    end
    alias_method :zero?, :zerop

    ##
    # @param  [Numeric, #odd?] n
    # @return [Boolean]
    def oddp(n)
      n.odd?
    end
    alias_method :odd?, :oddp

    ##
    # @param  [Numeric, #even?] n
    # @return [Boolean]
    def evenp(n)
      n.even?
    end
    alias_method :even?, :evenp
  end # module Numeric
end; end # module Trith::Core
