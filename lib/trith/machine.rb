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
    # a `halt` operator, or when encountering an error condition.
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
    def import!(mod)
      # Include all instance methods from the module into `self`:
      this = class << self; self; end
      this.send(:include, mod)

      mod.public_instance_methods(true).map(&:to_sym).each do |method|
        op = mod.instance_method(method).bind(self)
        if op.arity > 0
          # If the operator needs its arguments and result marshalled from
          # and to the virtual machine stack, create a wrapper method:
          @env[method] = this.send(:define_method, method) do |*args|
            result = op.call(*(args.empty? ? pop(op.arity) : args))
            push(result) unless result.equal?(self)
            return self
          end
        else
          @env[method] = op
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
    # If the queue doesn't have sufficient operands, throws a `:halt`
    # symbol.
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
      if queue.size < (n || 1)
        throw(:halt) # caught in `#execute`
      else
        n ? queue.shift(n) : queue.shift
      end
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
    # a `halt` operator, or when encountering an error condition.
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
      queue.unshift(*code) unless code.empty?

      catch(:halt) do # thrown in `#shift`
        while true
          op = shift
          case
            when operator?(op)
              if fn = @env[op]
                fn.call
              else
                unshift(op)
                raise InvalidOperatorError.new(op)
              end
            when operand?(op)
              push(op)
            else
              raise InvalidOperandError.new(op)
          end
        end
      end

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else instance_eval(&block)
        end
      end

      return self
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
        raise InvalidOperatorError.new(operator)
      end
    end

    ###
    # Invalid operator
    class InvalidOperatorError < NoMethodError
      attr_reader :operator

      def initialize(operator)
        @operator = operator
        super("invalid operator `#{operator}'")
      end
    end

    ###
    # Invalid operand
    class InvalidOperandError < ArgumentError
      attr_reader :operand
      attr_reader :operator

      def initialize(operand, operator = nil)
        @operand, @operator = operand, operator
        super("invalid operand #{operand.inspect}")
      end
    end

    ###
    # Stack underflow
    class StackUnderflowError < RuntimeError; end
  end # class Machine
end # module Trith
