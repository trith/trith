require 'machinery'

module Trith
  ##
  # Performs machine-independent local optimizations.
  class Optimizer < Machinery::Optimizer
    def self.optimize(program, options = {})
      self.optimize_pass(program)
    end

    def self.optimize_pass(program, options = {})
      EmptyQuotationElimination.transform(program)
      QuotationFactoring.transform(program)
      ConstantArithmeticFolding.transform(program)
      ConstantBitwiseFolding.transform(program)
      ConstantComparisonFolding.transform(program)
      ConstantBranchFolding.transform(program)
      AlgebraicSimplification.transform(program)
      StrengthReduction.transform(program)
      program
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
    # Performs partial evaluation of constant arithmetic operations.
    #
    # @see http://en.wikipedia.org/wiki/Constant_folding
    class ConstantArithmeticFolding < Optimizer::Peephole
      def match_instructions(instructions)
        case instructions
          when match(Integer, :neg)
            int, op = instructions.slice!(-2, 2)
            int = -int

          when match(Integer, :inc)
            int, op = instructions.slice!(-2, 2)
            int += 1

          when match(Integer, :dec)
            int, op = instructions.slice!(-2, 2)
            int -= 1

          when match(Integer, Integer, [:+, :-, :*])
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.send(op, rhs)

          when match(Integer, Integer, :'/')
            lhs, rhs, op = instructions.slice(-3, 3)
            if lhs % rhs == 0
              instructions.slice!(-3, 3)
              lhs.send(op, rhs)
            else
              super(instructions)
            end

          when match(Integer, Integer, :rem)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.remainder(rhs)

          when match(Integer, Integer, :mod)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.modulo(rhs)

          when match(Integer, Integer, :pow)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.send(:**, rhs)

          when match(Integer, [:abs])
            int, op = instructions.slice!(-2, 2)
            int.send(op)

          when match(Integer, [:min, :max])
            lhs, rhs, op = instructions.slice!(-3, 3)
            [lhs, rhs].send(op)

          else super
        end
      end
    end

    ##
    # Performs partial evaluation of constant bitwise operations.
    #
    # @see http://en.wikipedia.org/wiki/Constant_folding
    class ConstantBitwiseFolding < Optimizer::Peephole
      OPERATORS = {:not => :~, :and => :&, :or => :|, :xor => :^, :shl => :<<, :shr => :>>}

      def match_instructions(instructions)
        case instructions
          when match(Integer, Integer, OPERATORS.keys)
            super(instructions) # TODO

          when match(Integer, Integer, OPERATORS.values)
            super(instructions) # TODO

          else super
        end
      end
    end

    ##
    # Performs partial evaluation of constant comparison operations.
    #
    # @see http://en.wikipedia.org/wiki/Constant_folding
    class ConstantComparisonFolding < Optimizer::Peephole
      OPERATORS = {:cmp => :<=>, :eq  => :==, :ne  => :'!=', :lt  => :<, :le  => :<=, :gt  => :>, :ge  => :>=}

      def match_instructions(instructions)
        case instructions
          when match(Integer, Integer, [:ne, :'!='])
            lhs, rhs, op = instructions.slice!(-3, 3)
            !lhs.send(:==, rhs)

          when match(Integer, Integer, OPERATORS.keys)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.send(OPERATORS[op], rhs)

          when match(Integer, Integer, OPERATORS.values)
            lhs, rhs, op = instructions.slice!(-3, 3)
            lhs.send(op, rhs)

          else super
        end
      end
    end

    ##
    # Performs partial evaluation of constant branch operations.
    #
    # @see http://en.wikipedia.org/wiki/Constant_folding
    class ConstantBranchFolding < Optimizer::Peephole
      def match_instructions(instructions)
        super(instructions) # TODO
      end
    end

    ##
    # Simplifies arithmetic operations using algebraic identities.
    #
    # @see http://en.wikipedia.org/wiki/Peephole_optimization
    class AlgebraicSimplification < Optimizer::Peephole
      def match_instructions(instructions)
        case instructions
          when match(var, 0, :+)     then var
          when match(0, var, :+)     then var

          when match(var, 0, :-)     then var
          when match(var, var, :-)   then 0

          when match(var, 0, :*)     then 0
          when match(0, var, :*)     then 0
          when match(var, 1, :*)     then var
          when match(1, var, :*)     then var

          when match(var, 1, :'/')   then var
          when match(var, var, :'/') then 1

          when match(var, 0, :pow)   then 1
          when match(var, 1, :pow)   then var

          else super
        end
      end
    end

    ##
    # Replaces operations with equivalent but less costly operations.
    #
    # @see http://en.wikipedia.org/wiki/Strength_reduction
    class StrengthReduction < Optimizer::Peephole
      def match_instructions(instructions)
        case instructions
          when match(var, 1, :+)     then [var, :inc]
          when match(1, var, :+)     then [var, :inc]

          when match(var, 1, :-)     then [var, :dec]
          when match(0, var, :-)     then [var, :neg]
          when match(1, var, :-)     then [var, :neg, :inc]
          when match(var, var, :-)   then [var, :drop, 0]

          when match(var, 2, :*)     then [var, :dup, :+]

          when match(var, var, :'/') then [var, :drop, 1]

          when match(var, 2, :pow)   then [var, :dup, :*]
          when match(var, 3, :pow)   then [var, :dup, :dup, :*, :*]

          else super
        end
      end
    end

  end
end
