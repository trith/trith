module Trith
  class Program
    include Enumerable

    attr_accessor :definitions
    attr_accessor :quotations
    attr_accessor :instructions

    def self.open(file, &block)
      program = Reader.read_file(file)
      block.call(program) if block_given?
    end

    def initialize(definitions = {}, &block)
      @definitions  = definitions
      @quotations   = {}
      @instructions = []

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else instance_eval(&block)
        end
      end
    end

    def dup
      self.class.new do |copy|
        copy.definitions  = definitions.dup
        copy.quotations   = quotations.dup
        copy.instructions = instructions.dup
      end
    end

    def each(&block)
      definitions.each(&block)
    end

    def define(name, instructions)
      unless name
        definitions[name = gensym] = instructions
      else
        definitions[name = name.to_sym] = instructions
      end
      name
    end

    def defined?(name_or_quotation)
      case name_or_quotation
        when Array, SXP::List
          definitions.has_value?(name_or_quotation)
        else
          definitions.has_key?(name_or_quotation.to_sym)
      end
    end

    def <<(insns)
      if insns.respond_to?(:each)
        instructions.push(*insns)
      else
        instructions << insns
      end
      self
    end

    def gensym(prefix = '_')
      @gensym ||= 0
      @gensym += 1
      "#{prefix}g#{@gensym}".to_sym
    end

    class Literal
      attr_accessor :value

      def initialize(value)
        @value = value
      end
    end
  end
end
