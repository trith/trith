module Trith
  class Compiler
    attr_accessor :program

    def self.compile(files, options = {}, &block)
      require 'sxp' unless defined?(::SXP)

      compiler = self.new(options)
      [files].flatten.each do |file|
        compiler << SXP.read_file(file)
      end

      compiler.compile!
    end

    def initialize(options = {}, &block)
      @options = options
      @program = Program.new

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else instance_eval(&block)
        end
      end
    end

    def <<(insns)
      program << insns
      self
    end

    def optimize!
      Optimizer.optimize(program)
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
        when URI # Addressable::URI?
          compile_reference(instruction, *args)
        when Symbol
          compile_symbol(instruction, *args)
        when Array, SXP::List
          compile_quotation(instruction, *args)
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

    def compile_reference(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def compile_symbol(instruction, *args)
      case instruction
        when :nil    then compile_nil(nil, *args)
        when :false  then compile_boolean(false, *args)
        when :true   then compile_boolean(true, *args)
        else raise NotImplementedError # this is for subclasses to implement
      end
    end

    def compile_quotation(instruction)
      raise NotImplementedError # this is for subclasses to implement
    end

    def inlined?(instruction, options = {})
      !!inline_level(instruction, options)
    end

    def inline_level(instruction, options = {})
      options[:inline]
    end

  end
end
