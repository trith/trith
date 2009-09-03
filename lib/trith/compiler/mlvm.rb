require 'trith/compiler/jvm'

module Trith class Compiler
  class MLVM < JVM
    BiteScript.bytecode_version = BiteScript::JAVA1_7

    # TODO: an invokedynamic-enabled version of the JVM compiler.
  end
end end
