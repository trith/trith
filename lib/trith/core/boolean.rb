module Trith; module Core
  ##
  # Boolean operators.
  #
  # @see http://ruby-doc.org/core-1.9/classes/NilClass.html
  # @see http://ruby-doc.org/core-1.9/classes/FalseClass.html
  # @see http://ruby-doc.org/core-1.9/classes/TrueClass.html
  # @see http://en.wikipedia.org/wiki/Nil#Computer_programming
  # @see http://en.wikipedia.org/wiki/Boolean_data_type
  module Boolean
    ##
    # Boolean predicates.
    module Predicates
      ##
      # @param  [Object, #nil?] obj
      # @return [Boolean]
      def nilp(obj)
        obj.nil?
      end
      alias_method :nil?, :nilp

      ##
      # @param  [Object]  obj
      # @return [Boolean]
      def boolp(obj)
        obj.equal?(false) || obj.equal?(true)
      end
      alias_method :bool?, :boolp

      ##
      # @param  [Object]  obj
      # @return [Boolean]
      def falsep(obj)
        obj.equal?(false)
      end
      alias_method :false?, :falsep

      ##
      # @param  [Object]  obj
      # @return [Boolean]
      def truep(obj)
        obj.equal?(true)
      end
      alias_method :true?, :truep

      ##
      # @param  [Object] a
      # @return [Object]
      def notp(a)
        !a
      end
      alias_method :not?, :notp

      ##
      # @param  [Object] a
      # @param  [Object] b
      # @return [Object]
      def andp(a, b)
        a && b
      end
      alias_method :and?, :andp

      ##
      # @param  [Object] a
      # @param  [Object] b
      # @return [Object]
      def orp(a, b)
        a || b
      end
      alias_method :or?, :orp

      ##
      # @param  [Object] a
      # @param  [Object] b
      # @return [Object]
      def xorp(a, b)
        a ^ b
      end
      alias_method :xor?, :xorp
    end # module Predicates

    ##
    # Boolean constructors.
    module Constructors
      ##
      # @return [NilClass]
      def nil
        nil
      end

      ##
      # @param  [Object]  obj
      # @return [Boolean]
      def bool(obj)
        !!obj
      end

      ##
      # @return [FalseClass]
      def false
        false
      end

      ##
      # @return [TrueClass]
      def true
        true
      end
    end # module Constructors

    # Include all submodule methods directly into Trith::Core::Boolean:
    constants.each { |mod| include(const_get(mod)) }
  end # module Boolean
end; end # module Trith::Core
