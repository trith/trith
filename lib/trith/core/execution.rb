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
    def call(quot)
      case quot
        when Array
          unshift(*quot)
        when Symbol
          unshift(quot) # FIXME
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
            unshift(quot) # FIXME
          end
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def loop(quot)
      case quot
        when Array
          unshift(quot, :loop)
          unshift(*quot)
        when Symbol
          unshift(quot, :quote, quot, :loop) # FIXME
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def branch
      self # TODO
    end

    ##
    # @return [Machine]
    def print(obj)
      $stdout.puts(obj) # FIXME
      self
    end
    alias_method :'.', :print
  end # module Execution
end; end # module Trith::Core
