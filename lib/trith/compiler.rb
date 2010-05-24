module Trith
  ##
  # A base class for Trith compiler targets.
  #
  # @abstract
  class Compiler
    autoload :Ruby, 'trith/compiler/ruby'

    # @return [Hash{Symbol => Object}]
    attr_reader :options

    ##
    # @param  [Symbol, #to_sym] target
    # @return [Class]
    def self.for(target = nil, &block)
      target = block.call if block_given?
      case target.to_sym
        when :ruby then Ruby
        else nil
      end
    end

    ##
    # @param  [Array<String>]          filenames
    # @param  [Hash{Symbol => Object}] options
    # @return [Compiler]
    def self.compile_files(*filenames)
      options = filenames.last.is_a?(Hash) ? filenames.peek : {}
      self.compile(Reader.read_files(*filenames), options)
    end

    ##
    # @param  [Enumerable]             program
    # @param  [Hash{Symbol => Object}] options
    # @return [Compiler]
    def self.compile(program, options = {})
      self.new(options).compile(program, options)
    end

    ##
    # @param  [Hash{Symbol => Object}] options
    def initialize(options = {})
      @options = options.to_hash.dup
    end

    ##
    # @param  [Enumerable]             program
    # @param  [Hash{Symbol => Object}] options
    # @return [Compiler]
    def compile(program, options = {})
      program = program.respond_to?(:each) ? program : [program]
      program.each { |op| compile_operand(op) }
      self
    end

    protected

    ##
    # @param  [Object] operand
    # @return [void]
    def compile_operand(operand)
      case operand
        when Symbol
          compile_operator(operand)
        when NilClass
          compile_nil(operand)
        when TrueClass, FalseClass
          compile_boolean(operand)
        when Numeric
          compile_number(operand)
        when String
          compile_string(operand)
        when URI
          compile_reference(operand)
        when Array, SXP::List
          compile_quotation(operand)
        when Machine, Function
          compile_quotation(operand.to_a)
        else
          raise NotImplementedError.new("#{self.class}#compile_operand(#{operand.inspect})")
      end
    end

    ##
    # @param  [Symbol, #to_sym] operator
    # @return [void]
    # @abstract
    def compile_operator(operator)
      case operator.to_sym
        when :nil   then compile_nil(nil)
        when :false then compile_boolean(false)
        when :true  then compile_boolean(true)
        else raise NotImplementedError.new("#{self.class}#compile_operator(#{operator.inspect})")
      end
    end

    ##
    # @param  [NilClass] operand
    # @return [void]
    # @abstract
    def compile_nil(operand = nil)
      raise NotImplementedError.new("#{self.class}#compile_nil")
    end

    ##
    # @param  [Boolean] operand
    # @return [void]
    # @abstract
    def compile_boolean(operand)
      raise NotImplementedError.new("#{self.class}#compile_boolean(#{operand.inspect})")
    end

    ##
    # @param  [Numeric] operand
    # @return [void]
    # @abstract
    def compile_number(operand)
      case operand
        when Integer
          compile_integer(operand)
        when Float
          compile_float(operand)
        when BigDecimal
          compile_decimal(operand)
        when Rational
          compile_rational(operand)
        else
          raise NotImplementedError.new("#{self.class}#compile_number(#{operand.inspect})")
      end
    end

    ##
    # @param  [Integer] operand
    # @return [void]
    # @abstract
    def compile_integer(operand)
      raise NotImplementedError.new("#{self.class}#compile_integer(#{operand.inspect})")
    end

    ##
    # @param  [Float] operand
    # @return [void]
    # @abstract
    def compile_float(operand)
      raise NotImplementedError.new("#{self.class}#compile_float(#{operand.inspect})")
    end

    ##
    # @param  [BigDecimal] operand
    # @return [void]
    # @abstract
    def compile_decimal(operand)
      raise NotImplementedError.new("#{self.class}#compile_decimal(#{operand.inspect})")
    end

    ##
    # @param  [Rational] operand
    # @return [void]
    # @abstract
    def compile_rational(operand)
      raise NotImplementedError.new("#{self.class}#compile_rational(#{operand.inspect})")
    end

    ##
    # @param  [String] operand
    # @return [void]
    # @abstract
    def compile_string(operand)
      raise NotImplementedError.new("#{self.class}#compile_string(#{operand.inspect})")
    end

    ##
    # @param  [URI]  operand
    # @return [void]
    # @abstract
    def compile_reference(operand)
      raise NotImplementedError.new("#{self.class}#compile_reference(#{operand.inspect})")
    end

    ##
    # @param  [Array] operand
    # @return [void]
    # @abstract
    def compile_quotation(operand)
      raise NotImplementedError.new("#{self.class}#compile_quotation(#{operand.inspect})")
    end

    ##
    # @private
    def self.inherited(subclass)
      subclass.send(:public_class_method, :new)
      super
    end

    # Prevent the instantiation of this class:
    private_class_method :new
  end # class Compiler
end # module Trith
