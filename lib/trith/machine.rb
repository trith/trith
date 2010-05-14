module Trith
  ##
  # The Trith virtual machine.
  class Machine
    # @return [Array]
    attr_reader :stack

    # @return [Array]
    attr_reader :queue

    ##
    # Executes `code` in a new virtual machine instance.
    #
    # The machine will halt when the queue is exhausted, when encountering
    # a `halt` instruction, or when encountering an error condition.
    #
    # @overload self.execute(code)
    #   @param  [Array] code
    #   @return [Object]
    #
    # @overload self.execute(code) { |machine| ... }
    #   @param  [Array] code
    #   @yield  [machine]
    #   @yieldparam [Machine] machine
    #   @return [Object]
    #
    # @return [Object]
    def self.execute(code = [], &block)
      self.new([], code).execute(&block).peek
    end

    ##
    # Initializes a new virtual machine with the given initial `stack`,
    # `queue` and environment.
    #
    # @param  [Array] stack
    # @param  [Array] queue
    # @param  [Hash]  env
    # @yield  [machine]
    # @yieldparam [Machine] machine
    def initialize(stack = [], queue = [], env = {}, &block)
      @stack, @queue, @env = stack, queue, env
      execute(&block) if block_given?
    end

    ##
    # Imports operators from the given `module` into the virtual machine's
    # current environment.
    #
    # @param  [Module] module
    # @return [Machine]
    def import(mod)
      # Include all instance methods from the module into `self`:
      this = class << self; self; end
      this.send(:include, mod)

      # If any operators need their arguments and result marshalled from and
      # to the virtual machine stack, create wrapper methods to do that:
      mod.public_instance_methods(true).map(&:to_sym).each do |method|
        if (op = mod.instance_method(method)).arity > 0
          op = op.bind(self)
          this.send(:define_method, method) do |*args|
            result = op.call(*(args.empty? ? pop(op.arity) : args))
            push(result) unless result.equal?(self)
            return self
          end
        end
      end

      self
    end

    ##
    # Returns the concatenation of the stack and queue.
    #
    # @return [Array]
    def to_a
      (stack + queue).to_a
    end

    ##
    # Returns the operand at the top of the stack.
    #
    # If the stack is empty, returns `nil`.
    #
    # @return [Object]
    def peek
      stack.last
    end

    ##
    # Pops and returns one or more operands off the top of the stack.
    #
    # If the stack doesn't have sufficient operands, raises a stack
    # underflow error.
    #
    # @overload pop
    #   @return [Object]
    #
    # @overload pop(n)
    #   @param  [Integer] n
    #   @return [Array]
    #
    # @return [Object]
    # @raise  [StackUnderflowError]
    def pop(n = nil)
      if stack.size < (n || 1)
        raise StackUnderflowError.new
      else
        n ? stack.pop(n) : stack.pop
      end
    end

    ##
    # Pushes the given operands onto the top of the stack.
    #
    # If no operands were given, shifts an operand off the front of the
    # queue.
    #
    # @overload push
    #   @return [Machine]
    #
    # @overload push(*ops)
    #   @param  [Array] ops
    #   @return [Machine]
    #
    # @return [Machine]
    def push(*ops)
      stack.push(*(ops.empty? ? [shift] : ops))
      self
    end

    ##
    # Shifts and returns one or more operands off the front of the queue.
    #
    # If the queue doesn't have sufficient operands, returns the `halt`
    # operator.
    #
    # @overload shift
    #   @return [Object]
    #
    # @overload shift(n)
    #   @param  [Integer] n
    #   @return [Array]
    #
    # @return [Object]
    def shift(n = nil)
      n ? queue.shift(n) : (!queue.empty? ? queue.shift : :halt)
    end

    ##
    # Prepends the given operands onto the front of the queue.
    #
    # If no operands were given, pops an operand off the top of the stack.
    #
    # @overload unshift
    #   @return [Machine]
    #
    # @overload unshift(*ops)
    #   @param  [Array] ops
    #   @return [Machine]
    #
    # @return [Machine]
    def unshift(*ops)
      queue.unshift(*(ops.empty? ? [pop] : ops))
      self
    end

    ##
    # Executes the virtual machine until it halts.
    #
    # The machine will halt when the queue is exhausted, when encountering
    # a `halt` instruction, or when encountering an error condition.
    #
    # @overload execute(code)
    #   @param  [Array] code
    #   @return [Machine]
    #
    # @overload execute(code) { |machine| ... }
    #   @param  [Array] code
    #   @yield  [machine]
    #   @yieldparam [Machine] machine
    #   @return [Machine]
    #
    # @return [Machine]
    def execute(code = [], &block)
      queue.push(*code) unless code.empty?

      until (op = shift) == :halt
        case
          when operator?(op) then __send__(op)
          when operand?(op)  then push(op)
        end
      end

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else instance_eval(&block)
        end
      end

      self
    end

    protected

    ##
    # Returns `true` if `op` is an operator.
    #
    # @param  [Object] op
    # @return [Boolean]
    def operator?(op)
      op.is_a?(Symbol)
    end

    ##
    # Returns `true` if `op` is an operand.
    #
    # @param  [Object] op
    # @return [Boolean]
    def operand?(op)
      !operator?(op)
    end

    ##
    # Returns `true` if `op` is a quotation.
    #
    # @param  [Object] op
    # @return [Boolean]
    def quotation?(op)
      op.is_a?(Array)
    end

    ##
    # @private
    def method_missing(operator, *operands, &block)
      begin
        super
      rescue NoMethodError => e
        raise InvalidOperatorError.new("invalid operator `#{operator}'")
      end
    end

    ###
    # Invalid operator
    class InvalidOperatorError < NoMethodError; end

    ###
    # Stack underflow
    class StackUnderflowError < RuntimeError; end
  end # class Machine
end # module Trith
