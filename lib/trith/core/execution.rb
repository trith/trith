module Trith; module Core
  ##
  # Execution control operators.
  module Execution
    ##
    # @return [Machine]
    def nop
      self # do nothing
    end
    alias_method :';', :nop
    alias_method :',', :nop

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
    def times(quot, count)
      case quot
        when Array
          count.to_i.times { unshift(*quot) }
        when Symbol
          count.to_i.times { unshift(quot) } # FIXME
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def twice(quot)
      case quot
        when Array
          2.times { unshift(*quot) }
        when Symbol
          2.times { unshift(quot) } # FIXME
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def thrice(quot)
      case quot
        when Array
          3.times { unshift(*quot) }
        when Symbol
          3.times { unshift(quot) } # FIXME
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
    def while(quot, pred)
      with_saved_continuation(:while) do
        Kernel.loop do
          execute(pred)
          case pop
            when false, nil then break
            else execute(quot)
          end
        end
      end
      self
    end

    ##
    # @return [Machine]
    def until(quot, pred)
      with_saved_continuation(:until) do
        Kernel.loop do
          execute(pred)
          case pop
            when false, nil then execute(quot)
            else break
          end
        end
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
