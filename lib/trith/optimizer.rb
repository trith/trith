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
      ConstantArithmeticFolding.transform(program)
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

    ##
    # Performs partial evaluation of constant expressions.
    #
    # @see http://en.wikipedia.org/wiki/Constant_folding
    class ConstantArithmeticFolding < Optimizer::Peephole
      def match_instructions(instructions)
        case instructions
          when match(Integer, Integer, [:+, :-, :*])
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.send(op, rhs)
          when match(Integer, Integer, :'/')
            lhs, rhs, op = instructions.slice(-3, 3)
            if lhs % rhs == 0
              instructions.slice!(-3, 3)
              lhs.send(op, rhs)
            end
          when match(Integer, Integer, :mod)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.modulo(rhs)
          when match(Integer, Integer, :rem)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.remainder(rhs)
          when match(Integer, Integer, :pow)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.send(:**, rhs)
          when match(Integer, :neg)
            int, op = instructions.slice!(-2, 2)
            -int
          when match(Integer, [:abs])
            int, op = instructions.slice!(-2, 2)
            int.send(op)
        end
      end
    end

  end
end
