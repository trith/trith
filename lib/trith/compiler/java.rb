module Trith; class Compiler
  ##
  # A Trith-to-Java compiler.
  class Java < Compiler
    ##
    # @param  [Hash{Symbol => Object}] options
    def initialize(options = {})
      super(options)
      @options[:class] ||= 'a'
      @output = StringIO.new
    end

    ##
    # @return [String]
    def to_s
      output = StringIO.new
      output.puts "package #{@options[:package]};" if @options[:package]
      output.puts "import trith.lang.*;"
      output.puts "import trith.core.*;"
      output.puts
      output.puts "public class #{@options[:class]} implements Operator {"
      output.puts "  public static void main(String[] args) {"
      output.puts "    Operator self = new #{@options[:class]}();"
      output.puts "    self.execute(new StandardMachine());"
      output.puts "  }"
      output.puts
      output.puts "  public void execute(Machine machine) {"
      output.write @output.string
      output.puts "  }"
      output.puts "}"
      output.string
    end

    protected

    ##
    # @see Trith::Compiler#compile_operator
    # @private
    def compile_operator(operator)
      emit("machine.#{operator}();") # FIXME
    end

    ##
    # @see Trith::Compiler#compile_nil
    # @private
    def compile_nil(operand = nil)
      emit("machine.push(null);")
    end

    ##
    # @see Trith::Compiler#compile_boolean
    # @private
    def compile_boolean(operand)
      emit("machine.push(#{operand});")
    end

    ##
    # @see Trith::Compiler#compile_number
    # @private
    def compile_number(operand)
      emit("machine.push(#{operand});") # FIXME
    end

    alias_method :compile_integer,  :compile_number
    alias_method :compile_float,    :compile_number
    alias_method :compile_decimal,  :compile_number
    alias_method :compile_rational, :compile_number

    ##
    # @see Trith::Compiler#compile_string
    # @private
    def compile_string(operand)
      emit("machine.push(#{operand.inspect});") # FIXME
    end

    ##
    # @see Trith::Compiler#compile_reference
    # @private
    def compile_reference(operand)
      emit("machine.push(#{operand.to_s.inspect});") # FIXME
    end

    ##
    # @see Trith::Compiler#compile_quotation
    # @private
    def compile_quotation(operand)
      emit("machine.push(#{operand.inspect});") # FIXME
    end

    ##
    # @param  [String, #to_s] line
    # @return [void]
    def emit(line)
      @output.puts("    " << line.to_s)
    end
  end # class Java
end; end # class Trith::Compiler
