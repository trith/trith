require 'machinery/target/jvm'
require 'machinery/format/jar'

module Trith class Compiler
  class JVM < Compiler
    BiteScript.bytecode_version = BiteScript::JAVA1_5

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
