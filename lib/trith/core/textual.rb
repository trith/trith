module Trith; module Core
  ##
  # Textual operators.
  #
  # @see http://ruby-doc.org/core-1.9/classes/String.html
  module Textual
    ##
    # Textual predicates.
    module Predicates
      ##
      # @param  [Object]  obj
      # @return [Boolean]
      def charp(obj)
        case obj
          when String then obj.size == 1
          else false
        end
      end
      alias_method :char?, :charp

      ##
      # @param  [Object]  obj
      # @return [Boolean]
      def textp(obj)
        case obj
          when String then true
          else false
        end
      end
      alias_method :text?, :textp
    end

    ##
    # Textual constructors.
    module Constructors
      ##
      # @param  [Object]  obj
      # @return [String]
      def char(obj)
        case obj # FIXME
          when String then obj.chr
          else obj.to_s.chr
        end
      end

      ##
      # @param  [Object]  obj
      # @return [String]
      def text(obj)
        case obj
          when String then obj
          else obj.to_s # FIXME
        end
      end
    end # module Constructors

    ##
    # Textual operators.
    module Operators
      ##
      # @param  [String]  str
      # @return [Integer]
      def size(str)
        case str
          when String then str.bytesize
          else -1 # TODO: error
        end
      end
    end # module Operators

    # Include all submodule methods directly into Trith::Core::Textual:
    constants.each { |mod| include(const_get(mod)) }
  end # module Textual
end; end # module Trith::Core
