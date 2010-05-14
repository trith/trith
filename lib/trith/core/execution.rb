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
      case quot = pop
        when Array
          unshift(*quot)
        when Symbol
          unshift(quot)
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def times
      case quot = pop
        when Array
          pop.to_i.times do
            unshift(*quot)
          end
        when Symbol
          pop.to_i.times do
            unshift(quot)
          end
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def loop
      case quot = pop
        when Array
          unshift(quot, :loop)
          unshift(*quot)
        when Symbol
          unshift(quot, :quote, quot, :loop)
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
