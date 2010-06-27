module Trith; module Core
  ##
  # Stack operators.
  module Stack
    ##
    # Stack shufflers.
    module Shufflers
      ##
      # @return [Machine]
      def clear
        @stack.clear
        self
      end

      ##
      # @return [Machine]
      def depth
        push(@stack.size)
      end

      ##
      # @return [Machine]
      def stack_
        @stack = [@stack]
        self
      end

      ##
      # @param  [#to_a, #each]
      # @return [Machine]
      def unstack(seq)
        @stack = case seq
          when String then seq.each_char.to_a
          when Array  then seq
          else case
            when seq.respond_to?(:to_a) then seq.to_a
            when seq.respond_to?(:each) then seq.each.to_a
            else raise Machine::InvalidOperandError.new(seq, :unstack)
          end
        end
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
      def rot(a, b, c)
        push(b, c, a)
      end
    end # module Shufflers

    ##
    # Stack combinators.
    module Combinators
      ##
      # @return [Machine]
      def dip
        # TODO
      end
    end # module Combinators

    # Include all submodule methods directly into Trith::Core::Stack:
    constants.each { |mod| include(const_get(mod)) }
  end # module Stack
end; end # module Trith::Core
