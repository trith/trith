require 'machinery/target/llvm'
require 'machinery/format/bc'

module Trith class Compiler
  class LLVM < Compiler

    def compile(program)
      # TODO
    end

    def compile_nil(instruction)
      super # TODO
    end

    def compile_boolean(instruction)
      super # TODO
    end

    def compile_integer(instruction)
      super # TODO
    end

    def compile_number(instruction)
      super # TODO
    end

    def compile_string(instruction)
      super # TODO
    end

    def compile_reference(instruction)
      super # TODO
    end

    def compile_symbol(instruction)
      super # TODO
    end

    def compile_quotation(instruction)
      super # TODO
    end

  end
end end