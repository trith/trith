module Trith
  class Machine
    attr_accessor :stack
    attr_accessor :queue

    def self.execute(code = [], &block)
      self.new([], code).execute(&block)
    end

    def initialize(stack = [], queue = [], env = {}, &block)
      @stack, @queue, @env = stack, queue, env
      execute(&block) if block_given?
    end

    def to_a
      (stack + queue).to_a
    end

    # Stack operations

    def peek
      stack.last
    end

    def pop(n = nil)
      if stack.size < (n || 1)
        raise StackUnderflowError.new
      else
        !n ? stack.pop : stack.pop(n)
      end
    end

    def push(*args)
      stack.push(*(args.empty? ? [shift] : args))
      self
    end

    # Queue operations

    def shift(n = nil)
      !n ? (!queue.empty? ? queue.shift : :halt) : queue.shift(n)
    end

    def unshift(*args)
      queue.unshift(*(args.empty? ? [pop] : args))
      self
    end

    def execute(code = [], &block)
      queue.push(*code) unless code.empty? # FIXME

      until (op = shift) == :halt
        case
          when operator?(op) then send(op)
          when operand?(op)  then push(op)
        end
      end

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else instance_eval(&block)
        end
      end

      peek
    end

    protected

      def operator?(op) op.is_a?(Symbol) end
      def operand?(op)  !self.operator?(op) end
      def quotation(op) op.is_a?(Array) end

      undef_method :sub

      def method_missing(operator, *operands, &block)
        if instruction = Instruction.const_get(operator.to_s.upcase)
          if (arity = instruction.method(:execute).arity) > 0
            push(instruction.execute(*pop(arity)))
          else
            instruction.execute
          end
        else
          super
        end
      end

    ###
    # Stack underflow
    class StackUnderflowError < RuntimeError; end
  end
end
