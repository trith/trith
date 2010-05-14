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
    # @return [NilClass]
    def nil
      nil
    end

    ##
    # @param  [Object, #nil?] obj
    # @return [Boolean]
    def nilp(obj)
      obj.nil?
    end
    alias_method :nil?, :nilp

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

    # TODO: logical NOT, AND, OR, and XOR
  end # module Boolean
end; end # module Trith::Core
