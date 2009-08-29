require 'machinery'

module Trith
  ##
  # Performs machine-independent local optimizations.
  class Optimizer < Machinery::Optimizer
    def self.optimize(program, options = {})
      self.optimize_pass(program)
    end

    def self.optimize_pass(program, options = {})
      LiteralCanonicalization.transform(program)
      EmptyQuotationElimination.transform(program)
      QuotationFactoring.transform(program)
      program
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

    ##
    # Replaces empty quotations with the :nop instruction.
    class EmptyQuotationElimination < Optimizer
      def transform_instruction(instruction)
        case instruction
          when [] then :nop
          else super
        end
      end
    end

    ##
    # Converts quotations into equivalent gensym definitions.
    class QuotationFactoring < Optimizer
      def transform_instruction(quotation)
        case quotation
          when Array, SXP::List
            if program.defined?(quotation)
              program.definitions.index(quotation)
            else
              program.define(nil, quotation)
            end
          else super
        end
      end
    end

  end
end
