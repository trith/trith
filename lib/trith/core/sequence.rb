module Trith; module Core
  ##
  # Sequence operators.
  #
  # @see http://ruby-doc.org/core-1.9/classes/Enumerable.html
  # @see http://ruby-doc.org/core-1.9/classes/Enumerator.html
  # @see http://en.wikipedia.org/wiki/Sequence
  module Sequence
    ##
    # @param  [String, #each, #to_enum] obj
    # @return [Boolean]
    def seqp(obj)
      case obj
        when String then true
        when Array  then true
        else case
          when obj.respond_to?(:each)    then true
          when obj.respond_to?(:to_enum) then true
          else false
        end
      end
    end
    alias_method :seq?, :seqp

    ##
    # @param  [String, #each, #to_enum] obj
    # @return [Enumerator]
    def seq(obj)
      case obj
        when String then obj.each_char
        when Array  then obj.each
        else case
          when obj.respond_to?(:each)
            obj.each
          when obj.respond_to?(:to_enum)
            obj.to_enum
          else # TODO: error
        end
      end
    end

    ##
    # @overload cons(obj, seq)
    #   @param  [#to_s]        obj
    #   @param  [String]       seq
    #   @return [String]
    #
    # @overload cons(obj, seq)
    #   @param  [Object]       obj
    #   @param  [Array, #to_a] seq
    #   @return [Array]
    #
    # @return []
    def cons(obj, seq)
      case seq
        when String
          seq.dup.insert(0, obj.to_s.chr)
        when Array
          seq.dup.unshift(obj)
        else case
          when seq.respond_to?(:to_a)
            seq.to_a.unshift(obj)
          else # TODO: support for `#each`
        end
      end
    end

    ##
    # @param  [#empty?, #size, #each] seq
    # @return [Boolean]
    def emptyp(seq)
      case
        when seq.respond_to?(:empty?)
          seq.empty?
        when seq.respond_to?(:size)
          seq.size.zero?
        when seq.respond_to?(:each)
          seq.each.to_a.empty? # TODO: optimize
        else # TODO: error
      end
    end
    alias_method :empty?, :emptyp

    ##
    # @param  [#length, #size, #each] seq
    # @return [Integer]
    def length(seq)
      case
        when seq.respond_to?(:length)
          seq.length
        when seq.respond_to?(:size)
          seq.size
        when seq.respond_to?(:each)
          seq.each.to_a.size # TODO: optimize
        else # TODO: error
      end
    end

    ##
    # @param  [#rest, #[], #each] seq
    # @return [Enumerable]
    def rest(seq)
      # TODO: check semantics for empty sequences
      case
        when seq.respond_to?(:rest)
          seq.rest
        when seq.respond_to?(:[])
          seq[1..-1]
        when seq.respond_to?(:each)
          seq.each.to_a[1..-1] # TODO: optimize
        else # TODO: error
      end
    end

    ##
    # @param  [#first, #[], #each] seq
    # @return [Object]
    def first(seq)
      case seq
        when String
          seq[0].chr rescue nil # Ruby 1.8 compatible
        else case
          when seq.respond_to?(:first) then seq.first
          else nth(seq, 0)
        end
      end
    end

    ##
    # @param  [#second, #[], #each] seq
    # @return [Object]
    def second(seq)
      case
        when seq.respond_to?(:second) then seq.second
        else nth(seq, 1)
      end
    end

    ##
    # @param  [#third, #[], #each] seq
    # @return [Object]
    def third(seq)
      case
        when seq.respond_to?(:third) then seq.third
        else nth(seq, 2)
      end
    end

    ##
    # @param  [#fourth, #[], #each] seq
    # @return [Object]
    def fourth(seq)
      case
        when seq.respond_to?(:fourth) then seq.fourth
        else nth(seq, 3)
      end
    end

    ##
    # @param  [#fifth, #[], #each] seq
    # @return [Object]
    def fifth(seq)
      case
        when seq.respond_to?(:fifth) then seq.fifth
        else nth(seq, 4)
      end
    end

    ##
    # @param  [#sixth, #[], #each] seq
    # @return [Object]
    def sixth(seq)
      case
        when seq.respond_to?(:sixth) then seq.sixth
        else nth(seq, 5)
      end
    end

    ##
    # @param  [#seventh, #[], #each] seq
    # @return [Object]
    def seventh(seq)
      case
        when seq.respond_to?(:seventh) then seq.seventh
        else nth(seq, 6)
      end
    end

    ##
    # @param  [#eighth, #[], #each] seq
    # @return [Object]
    def eighth(seq)
      case
        when seq.respond_to?(:eighth) then seq.eighth
        else nth(seq, 7)
      end
    end

    ##
    # @param  [#ninth, #[], #each] seq
    # @return [Object]
    def ninth(seq)
      case
        when seq.respond_to?(:ninth) then seq.ninth
        else nth(seq, 8)
      end
    end

    ##
    # @param  [#tenth, #[], #each] seq
    # @return [Object]
    def tenth(seq)
      case
        when seq.respond_to?(:tenth) then seq.tenth
        else nth(seq, 9)
      end
    end

    ##
    # @param  [#nth, #[], #each] seq
    # @param  [Integer, #to_i]   n
    # @return [Object]
    def nth(seq, n)
      case seq
        when String
          seq[n.to_i].chr rescue nil # Ruby 1.8 compatible
        else case
          when seq.respond_to?(:nth)
            seq.nth(n)
          when seq.respond_to?(:[])
            seq[n.to_i]
          when seq.respond_to?(:each)
            seq.each.to_a[n.to_i] # TODO: optimize
          else # TODO: error
        end
      end
    end

    ##
    # @param  [#last, #[], #each] seq
    # @return [Object]
    def last(seq)
      case seq
        when String
          seq[-1].chr rescue nil # Ruby 1.8 compatible
        else case
          when seq.respond_to?(:last)
            seq.last
          when seq.respond_to?(:[])
            seq[-1]
          when seq.respond_to?(:each)
            seq.each.to_a.last # TODO: optimize
          else # TODO: error
        end
      end
    end

    ##
    # @param  [#reverse, #each] seq
    # @return [Enumerable]
    def reverse(seq)
      case seq
        when String then seq.reverse
        when Array  then seq.reverse
        else case
          when seq.respond_to?(:reverse)
            seq.last
          when seq.respond_to?(:each)
            seq.each.to_a.reverse # TODO: optimize
          else # TODO: error
        end
      end
    end
  end # module Sequence
end; end # module Trith::Core