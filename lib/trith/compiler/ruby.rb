module Trith; class Compiler
  ##
  # A Trith-to-Ruby compiler.
  class Ruby < Compiler
    SHEBANG = "#!/usr/bin/env ruby -rubygems"

    ##
    # @param  [Hash{Symbol => Object}] options
    def initialize(options = {})
      super(options)
      @options[:shebang] ||= SHEBANG
      @output = StringIO.new
    end

    ##
    # @return [String]
    def to_s
      output = StringIO.new
      output.puts @options[:shebang]
      output.puts "require 'rubygems'" if @options[:rubygems]
      output.puts "require 'trith'"
      output.puts
      output.puts "Trith::Machine.run(ARGV) do"
      output.write @output.string
      output.puts "end"
      output.string
    end

    protected

    ##
    # @see Trith::Compiler#compile_operator
    # @private
    def compile_operator(operator)
      emit("call(:#{operator}).execute")
    end

    ##
    # @see Trith::Compiler#compile_nil
    # @private
    def compile_nil(operand = nil)
      emit("push(nil)")
    end

    ##
    # @see Trith::Compiler#compile_boolean
    # @private
    def compile_boolean(operand)
      emit("push(#{operand})")
    end

    ##
    # @see Trith::Compiler#compile_number
    # @private
    def compile_number(operand)
      emit("push(#{operand})")
    end

    alias_method :compile_integer,  :compile_number
    alias_method :compile_float,    :compile_number
    alias_method :compile_decimal,  :compile_number
    alias_method :compile_rational, :compile_number

    ##
    # @see Trith::Compiler#compile_string
    # @private
    def compile_string(operand)
      emit("push(#{operand.inspect})")
    end

    ##
    # @see Trith::Compiler#compile_reference
    # @private
    def compile_reference(operand)
      emit("push(Trith::URI.new(#{operand.to_s.inspect}))")
    end

    ##
    # @see Trith::Compiler#compile_quotation
    # @private
    def compile_quotation(operand)
      emit("push(#{operand.inspect})")
    end

    ##
    # @param  [String, #to_s] line
    # @return [void]
    def emit(line)
      @output.puts("  " << line.to_s)
    end
  end # class Ruby
end; end # class Trith::Compiler
