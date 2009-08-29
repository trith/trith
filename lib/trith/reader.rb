require 'sxp' unless defined?(::SXP)

module Trith
  class Reader
    def self.read_files(files, options = {})
      program = Program.new
      [files].flatten.each do |file|
        program << SXP.read_file(file)
      end
      DefinitionTransformation.transform(program)
      LiteralCanonicalization.transform(program)
      program
    end

    def self.read_file(file, options = {})
      self.read_files([file])
    end

    ##
    # Removes static definitions from the instruction stream.
    class DefinitionTransformation < Optimizer::Peephole
      def transform
        program.instructions = transform_instructions(program.instructions)
        program
      end

      def match_instructions(instructions)
        case instructions
          when match(:':', Symbol, [Array, SXP::List])
            colon, name, quotation = instructions.slice!(-3, 3)
            program.define(name, quotation)
            super(instructions)
        end
      end
    end

    ##
    # Canonicalizes :nil, :true and :false instructions.
    class LiteralCanonicalization < Optimizer
      def transform_instruction(instruction)
        case instruction
          when :nil   then nil
          when :false then false
          when :true  then true
          else super
        end
      end
    end
  end
end
