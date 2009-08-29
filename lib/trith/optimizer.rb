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
      TailRecursionAnalysis.transform(program)
      ConstantArithmeticFolding.transform(program)
      ConstantBitwiseFolding.transform(program)
      ConstantComparisonFolding.transform(program)
      ConstantBranchFolding.transform(program)
      AlgebraicSimplification.transform(program)
      StrengthReduction.transform(program)
      RedundantCodeElimination.transform(program)
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
    # Replaces tail recursion with the :recur pseudo-instruction.
    #
    # @see http://en.wikipedia.org/wiki/Tail_recursion
    # @see http://en.wikipedia.org/wiki/Tail_call
    class TailRecursionAnalysis < Optimizer
      def transform_definition(name, instructions)
        @name = name
        super(name, instructions)
      end

      def transform_instruction(instruction)
        case instruction
          when @name then :recur
          else super
        end
      end
    end

    ##
    # Performs partial evaluation of constant arithmetic operations.
    #
    # @see http://en.wikipedia.org/wiki/Constant_folding
    class ConstantArithmeticFolding < Optimizer::Peephole
      OPERATORS = {:add => :+, :sub => :-, :mul => :*, :div => :'/'}

      def match_instructions(instructions)
        case instructions
          when match(Integer, Integer, [:div, :'/'])
            lhs, rhs, op = instructions.slice(-3, 3)
            if lhs % rhs == 0
              Machine.execute([lhs, rhs, :div])
            else
              super(instructions)
            end

          when match(Integer, Integer, OPERATORS.keys)
            Machine.execute(instructions.slice(-3, 3))

          when match(Integer, Integer, OPERATORS.values)
            lhs, rhs, op = instructions.slice(-3, 3)
            Machine.execute([lhs, rhs, OPERATORS.index(op)])

          when match(Integer, Integer, [:rem, :mod, :pow, :min, :max])
            Machine.execute(instructions.slice(-3, 3))

          when match(Integer, [:neg, :inc, :dec, :abs])
            Machine.execute(instructions.slice(-2, 2))

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
            Machine.execute(instructions.slice(-3, 3))

          when match(Integer, Integer, OPERATORS.values)
            lhs, rhs, op = instructions.slice(-3, 3)
            Machine.execute([lhs, rhs, OPERATORS.index(op)])

          else super
        end
      end
    end

    ##
    # Performs partial evaluation of constant comparison operations.
    #
    # @see http://en.wikipedia.org/wiki/Constant_folding
    class ConstantComparisonFolding < Optimizer::Peephole
      OPERATORS = {:cmp => :<=>, :eq => :==, :ne => :'!=', :lt => :<, :le => :<=, :gt => :>, :ge => :>=}

      def match_instructions(instructions)
        case instructions
          when match(Integer, Integer, OPERATORS.keys)
            Machine.execute(instructions.slice(-3, 3))

          when match(Integer, Integer, OPERATORS.values)
            lhs, rhs, op = instructions.slice(-3, 3)
            Machine.execute([lhs, rhs, OPERATORS.index(op)])

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
        case instructions
          when match([TrueClass, FalseClass], var(1), var(2), :branch)
            transform_branch(*instructions.slice(-4, 4))
          when match([:true, :false], var(1), var(2), :branch)
            transform_branch(*instructions.slice(-4, 4))
          else super
        end
      end

      def transform_branch(ifcond, ifthen, ifelse, branch = nil)
        case ifcond
          when TrueClass,  :true  then ifthen
          when FalseClass, :false then ifelse
          else fail_match
        end
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

    ##
    # Eliminates operations having no effect on the output of the program.
    #
    # @see http://en.wikipedia.org/wiki/Redundant_code
    class RedundantCodeElimination < Optimizer::Peephole
      def match_instructions(instructions)
        case instructions
          when match(:dup3, :drop3)           then []
          when match(:dup2, :drop2)           then []
          when match(:dup2, :drop, :drop)     then []
          when match(:dup, :drop)             then []
          when match(:dup, var, :swap, :drop) then [var]
          else super
        end
      end
    end

  end
end
