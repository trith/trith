module Trith
  class Instruction < Machinery::Architecture::Instruction
    def self.title(s)
      # TODO
    end

    def self.execute
      raise NotImplementedError
    end

    # Arithmetic operators

    class NEG < Instruction
      title "Negation"

      def self.execute(int)
        -int
      end
    end

    class INC < Instruction
      title "Increment"

      def self.execute(int)
        int + 1
      end
    end

    class DEC < Instruction
      title "Decrement"

      def self.execute(int)
        int - 1
      end
    end

    class ADD < Instruction
      title "Addition"

      def self.execute(lhs, rhs)
        lhs + rhs
      end
    end

    class SUB < Instruction
      title "Subtraction"

      def self.execute(lhs, rhs)
        lhs - rhs
      end
    end

    class MUL < Instruction
      title "Multiplication"

      def self.execute(lhs, rhs)
        lhs * rhs
      end
    end

    class DIV < Instruction
      title "Division"

      def self.execute(lhs, rhs)
        lhs / rhs
      end
    end

    class REM < Instruction
      title "Remainder"

      def self.execute(lhs, rhs)
        lhs.remainder(rhs)
      end
    end

    class MOD < Instruction
      title "Modulo"

      def self.execute(lhs, rhs)
        lhs.modulo(rhs)
      end
    end

    class POW < Instruction
      title "Exponentiation"

      def self.execute(lhs, rhs)
        lhs ** rhs
      end
    end

    class ABS < Instruction
      title "Modulus"

      def self.execute(int)
        int.abs
      end
    end

    class MIN < Instruction
      title "Minimum"

      def self.execute(lhs, rhs)
        [lhs, rhs].min
      end
    end

    class MAX < Instruction
      title "Maximum"

      def self.execute(lhs, rhs)
        [lhs, rhs].max
      end
    end

    # Bitwise operators

    class NOT < Instruction
      title "Inverse"

      def self.execute(int)
        ~int
      end
    end

    class AND < Instruction
      title "Bitwise AND"

      def self.execute(lhs, rhs)
        lhs & rhs
      end
    end

    class OR < Instruction
      title "Bitwise OR"

      def self.execute(lhs, rhs)
        lhs | rhs
      end
    end

    class XOR < Instruction
      title "Bitwise XOR"

      def self.execute(lhs, rhs)
        lhs ^ rhs
      end
    end

    class SHL < Instruction
      title "Shift left"

      def self.execute(lhs, rhs)
        lhs << rhs
      end
    end

    class SHR < Instruction
      title "Shift right"

      def self.execute(lhs, rhs)
        lhs >> rhs
      end
    end

    # Comparison operators

    class CMP < Instruction
      title "Comparison"

      def self.execute(lhs, rhs)
        lhs <=> rhs
      end
    end

    class EQ < Instruction
      title "Equality"

      def self.execute(lhs, rhs)
        lhs == rhs
      end
    end

    class NE < Instruction
      title "Inequality"

      def self.execute(lhs, rhs)
        lhs != rhs
      end
    end

    class LT < Instruction
      title "Less than"

      def self.execute(lhs, rhs)
        lhs < rhs
      end
    end

    class LE < Instruction
      title "Less than or equal"

      def self.execute(lhs, rhs)
        lhs <= rhs
      end
    end

    class GT < Instruction
      title "Greater than"

      def self.execute(lhs, rhs)
        lhs > rhs
      end
    end

    class GE < Instruction
      title "Greater than or equal"

      def self.execute(lhs, rhs)
        lhs >= rhs
      end
    end
  end
end
