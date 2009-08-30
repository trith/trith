module Trith
  class Instruction < Machinery::Architecture::Instruction
    def self.title(s)
      # TODO
    end

    def self.stack(*args)
      self.effect(*args)
    end

    def self.stack_effect() {} end
    def self.stack_height() 0 end

    def self.execute(&block)
      if block_given?
        case
          when block.arity == 0 || block.arity == -1
            # The instruction will use peek/pop/push manually:
            self.evaluator = lambda do
              instance_eval(&block)
              self
            end

          when block.arity > 0
            # The instruction needs its arguments and result marshalled from
            # and to the virtual machine stack:
            self.evaluator = lambda do
              push(block.call(*pop(block.arity)))
              self
            end
        end
      else
        raise NotImplementedError
      end
    end

    def self.evaluator=(proc)
      this = class << self; self; end
      this.send(:define_method, :evaluator) { proc }
    end

    # Queue operators

    class NOP < Instruction
      title "Do nothing"

      execute do end
    end

    class HALT < Instruction
      title "Halt machine"

      execute do queue.clear end
    end

    class CALL < Instruction
      title "Call quotation"

      execute do |op|
        # TODO
      end
    end

    class LOOP < Instruction
      title "Loop"

      execute do |op|
        # TODO
      end
    end

    class BRANCH < Instruction
      title "Branch"

      execute do |cond, thenop, elseop|
        # TODO
      end
    end

    # Stack operators

    class RESET < Instruction
      title "Clear stack"

      execute do stack.clear end
    end

    class POP < Instruction
      title "Drop operand"
      stack [:a] => []

      execute do pop end
    end

    class DUP < Instruction
      title "Duplicate operand"
      stack [:a] => [:a, :a]

      execute do push(peek) end
    end

    class SWAP < Instruction
      title "Swap operands"
      stack [:a, :b] => [:b, :a]

      execute do push(*pop(2).reverse) end
    end

    # Stack combinators

    class DIP < Instruction
      title "Dip into stack to execute quotation"

      execute do
        tmp, quot = pop(2)
        execute(quot)
        push(tmp)
      end
    end

    # Arithmetic operators

    class NEG < Instruction
      title "Negation"
      stack [:a] => [:b]

      execute do |int|
        -int
      end
    end

    class INC < Instruction
      title "Increment"
      stack [:a] => [:b]

      execute do |int|
        int + 1
      end
    end

    class DEC < Instruction
      title "Decrement"
      stack [:a] => [:b]

      execute do |int|
        int - 1
      end
    end

    class ADD < Instruction
      title "Addition"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs + rhs
      end
    end

    class SUB < Instruction
      title "Subtraction"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs - rhs
      end
    end

    class MUL < Instruction
      title "Multiplication"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs * rhs
      end
    end

    class DIV < Instruction
      title "Division"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs / rhs
      end
    end

    class REM < Instruction
      title "Remainder"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs.remainder(rhs)
      end
    end

    class MOD < Instruction
      title "Modulo"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs.modulo(rhs)
      end
    end

    class POW < Instruction
      title "Exponentiation"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs ** rhs
      end
    end

    class ABS < Instruction
      title "Modulus"
      stack [:a] => [:b]

      execute do |int|
        int.abs
      end
    end

    class MIN < Instruction
      title "Minimum"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        [lhs, rhs].min
      end
    end

    class MAX < Instruction
      title "Maximum"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        [lhs, rhs].max
      end
    end

    # Bitwise operators

    class NOT < Instruction
      title "Inverse"
      stack [:a] => [:b]

      execute do |int|
        ~int
      end
    end

    class AND < Instruction
      title "Bitwise AND"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs & rhs
      end
    end

    class OR < Instruction
      title "Bitwise OR"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs | rhs
      end
    end

    class XOR < Instruction
      title "Bitwise XOR"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs ^ rhs
      end
    end

    class SHL < Instruction
      title "Shift left"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs << rhs
      end
    end

    class SHR < Instruction
      title "Shift right"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs >> rhs
      end
    end

    # Comparison operators

    class CMP < Instruction
      title "Comparison"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs <=> rhs
      end
    end

    class EQ < Instruction
      title "Equality"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs == rhs
      end
    end

    class NE < Instruction
      title "Inequality"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs != rhs
      end
    end

    class LT < Instruction
      title "Less than"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs < rhs
      end
    end

    class LE < Instruction
      title "Less than or equal"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs <= rhs
      end
    end

    class GT < Instruction
      title "Greater than"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs > rhs
      end
    end

    class GE < Instruction
      title "Greater than or equal"
      stack [:a, :b] => [:c]

      execute do |lhs, rhs|
        lhs >= rhs
      end
    end

    # Debug operators

    class DUMP < Instruction
      title "Dump machine state"

      execute do
        puts "#{stack.inspect} : #{queue.inspect}"
      end
    end

  end
end
