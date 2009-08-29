module Trith
  class Program
    include Enumerable

    attr_accessor :definitions
    attr_accessor :quotations
    attr_accessor :instructions

    def initialize(definitions = {}, &block)
      @definitions  = definitions
      @quotations   = {}
      @instructions = []

      if block_given?
        block.call(self)
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
        until insns.empty?
          case insn = insns.shift
            when :":"
              define(insns.shift, insns.shift)
            when :branch
              instructions << insn
            else
              instructions << insn
          end
        end
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
