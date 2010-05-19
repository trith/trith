module Trith; module Core
  ##
  # Sequence operators.
  #
  # @see http://ruby-doc.org/core-1.9/classes/Enumerable.html
  # @see http://ruby-doc.org/core-1.9/classes/Enumerator.html
  # @see http://en.wikipedia.org/wiki/Sequence
  module Sequence
    ##
    # Sequence predicates.
    module Predicates
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
          else
            raise Machine::InvalidOperandError.new(seq, :emptyp)
        end
      end
      alias_method :empty?, :emptyp
    end # module Predicates

    ##
    # Sequence constructors.
    module Constructors
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
            else
              raise Machine::InvalidOperandError.new(obj, :seq)
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
      # @param  [Integer, #to_i] n
      # @return [Enumerable]
      def list(n)
        stack.pop(n.to_i)
      end

      ##
      # @param  [Integer, #to_i] n
      # @return [Enumerable]
      def iota(n)
        # TODO: should support negative ranges as well.
        (0...(n.to_i)).to_a
      end
    end # module Constructors

    ##
    # Sequence accessors.
    module Accessors
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
          else
            raise Machine::InvalidOperandError.new(seq, :length)
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
          else
            raise Machine::InvalidOperandError.new(seq, :rest)
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
            else
              raise Machine::InvalidOperandError.new(seq, :nth)
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
            else
              raise Machine::InvalidOperandError.new(seq, :last)
          end
        end
      end
    end # module Accessors

    ##
    # Sequence operators.
    module Operators
      ##
      # @param  [#concat, #each] seq1
      # @param  [#each]          seq2
      # @return [Enumerable]
      def concat(seq1, seq2)
        case
          when seq1.respond_to?(:concat)
            seq1.dup.concat(seq2)
          when seq1.respond_to?(:each)
            seq1.each.to_a.concat(seq2.each.to_a) # TODO: optimize
          else
            raise Machine::InvalidOperandError.new(seq1, :concat)
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
              seq.reverse
            when seq.respond_to?(:each)
              seq.each.to_a.reverse # TODO: optimize
            else
              raise Machine::InvalidOperandError.new(seq, :reverse)
          end
        end
      end

      ##
      # @param  [#flatten, #each] seq
      # @return [Enumerable]
      def flatten(seq)
        case seq
          when String then seq
          when Array  then seq.flatten
          else case
            when seq.respond_to?(:flatten)
              seq.flatten
            when seq.respond_to?(:each)
              seq.each.to_a.flatten # TODO: optimize
            else
              raise Machine::InvalidOperandError.new(seq, :flatten)
          end
        end
      end
    end # module Operators

    ##
    # Sequence combinators.
    module Combinators
      ##
      # @param  [#each] seq
      # @param  [Array] quot
      # @return [Machine]
      def each(seq, quot)
        seq = case seq
          when String then seq.each_char
          else case
            when seq.respond_to?(:each) then seq.each
            else raise Machine::InvalidOperandError.new(seq, :each)
          end
        end
        with_saved_continuation(:each) do
          seq.each { |elem| push(elem).execute(quot) }
        end
      end

      ##
      # @param  [#map, #each] seq
      # @param  [Array]       quot
      # @return [Machine]
      def map(seq, quot)
        seq = case seq
          when String then seq.each_char
          else case
            when seq.respond_to?(:map)  then seq
            when seq.respond_to?(:each) then seq.each
            else raise Machine::InvalidOperandError.new(seq, :map)
          end
        end
        with_saved_continuation(:map) do
          push(seq.map { |elem| push(elem).execute(quot).pop })
        end
      end

      ##
      # @param  [#reduce, #each] seq
      # @param  [Object]         identity
      # @param  [Array]          quot
      # @return [Machine]
      def foldl(seq, identity, quot)
        seq = case seq
          when String then seq.each_char
          else case
            when seq.respond_to?(:reduce) then seq
            when seq.respond_to?(:each)   then seq.each
            else raise Machine::InvalidOperandError.new(seq, :foldl)
          end
        end
        with_saved_continuation(:foldl) do
          push(seq.reduce(identity) { |prev, elem| push(prev, elem).execute(quot).pop })
        end
      end
    end # module Combinators

    # Include all submodule methods directly into Trith::Core::Sequence:
    constants.each { |mod| include(const_get(mod)) }
  end # module Sequence
end; end # module Trith::Core
