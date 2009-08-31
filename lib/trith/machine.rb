module Trith
  class Machine
    attr_reader :stack
    attr_reader :queue

    def self.execute(code = [], &block)
      self.new([], code).execute(&block).peek
    end

    def initialize(stack = [], queue = [], env = {}, &block)
      @stack, @queue, @env = stack, queue, env
      execute(&block) if block_given?
    end

    def to_a
      (stack + queue).to_a
    end

    def import(mod)
      this = class << self; self; end
      this.send(:include, mod)
      mod.public_instance_methods(true).map(&:to_sym).each do |method|
        if (op = mod.instance_method(method)).arity > 0
          op = op.bind(self)
          this.send(:define_method, method) do
            push(op.call(*pop(op.arity)))
          end
        end
      end
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

    def respond_to?(operator)
      super || (!!load_instruction(operator))
    end

    protected

      def operator?(op) op.is_a?(Symbol) end
      def operand?(op)  !self.operator?(op) end
      def quotation(op) op.is_a?(Array) end

      def method_missing(operator, *operands, &block)
        if link_instruction!(operator)
          __send__(operator, *operands, &block)
        else
          super
        end
      end

      ##
      # Attempts to dynamically link in any missing operator by loading its
      # implementation and monkey-patching a new method definition into the
      # virtual machine instance.
      def link_instruction!(operator)
        if instruction = load_instruction(operator)
          self.class.send(:define_method, operator, &instruction.evaluator)
        end
      end

      ##
      # Attempts to locate and load the instruction class implementation for
      # a given operator.
      def load_instruction(operator)
        # Each instruction is implemented as a subclass of Instruction:
        begin
          Instruction.const_get(operator.to_s.upcase)
        rescue NameError => e
          raise NameError, "invalid instruction :#{operator}"
        end
      end

      undef_method(*(instance_methods - instance_methods(false) -
        %w(__id__ __send__ class instance_eval inspect should should_not)))
      undef_method(:sub)

    ###
    # Stack underflow
    class StackUnderflowError < RuntimeError; end
  end
end
