module Trith; module Core
  ##
  # Execution control operators.
  module Execution
    ##
    # @return [Machine]
    def nop
      self # do nothing
    end

    ##
    # @return [Machine]
    def halt
      queue.clear
      self
    end

    ##
    # @return [Machine]
    def quote
      push(shift)
      self
    end
    alias_method :'\\', :quote
    alias_method :"'", :quote

    ##
    # @return [Machine]
    def call
      case value = pop
        when Array
          unshift(*value)
        when Symbol
          # TODO
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def loop
      case value = pop
        when Array
          unshift(value, :loop)
          unshift(*value)
        when Symbol
          # TODO
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def branch
      self # TODO
    end
  end # module Execution
end; end # module Trith::Core
