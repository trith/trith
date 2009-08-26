module Trith
  class Compiler
    attr_accessor :definitions
    attr_accessor :instructions

    def self.compile(files, options = {}, &block)
      require 'sxp' unless defined?(::SXP)

      compiler = self.new(options)
      [files].flatten.each do |file|
        compiler << SXP.read_file(file)
      end

      compiler.compile!
    end

    def initialize(options = {}, &block)
      @options      = options
      @definitions  = {}
      @instructions = []

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else instance_eval(&block)
        end
      end
    end

    def <<(instructions)
      if instructions.respond_to?(:to_ary)
        @instructions += instructions
      else
        @instructions << instructions
      end
      self
    end

    def compile!
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_instructions(instructions, *args)
      instructions.each do |instruction|
        compile_instruction(instruction, *args)
      end
    end

    def compile_instruction(instruction, *args)
      case instruction
        when NilClass
          compile_nil(instruction, *args)
        when TrueClass, FalseClass
          compile_boolean(instruction, *args)
        when Integer
          compile_integer(instruction, *args)
        when Numeric # Float, BigDecimal
          compile_number(instruction, *args)
        when String
          compile_string(instruction, *args)
        when Symbol
          compile_symbol(instruction, *args)
        when Array, SXP::List
          compile_quotation(instruction, *args)
        when URI # FIXME
          compile_reference(instruction, *args)
      end
    end

    def compile_nil(instruction = nil)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_boolean(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_integer(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_number(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_string(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_symbol(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_quotation(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_reference(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    protected

      def gensym(prefix = '_')
        @gensym ||= 0
        @gensym += 1
        "#{prefix}g#{@gensym}".to_sym
      end

  end
end
