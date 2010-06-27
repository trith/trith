module Trith; module Core
  ##
  # Execution control operators.
  module Execution
    ##
    # @return [Machine]
    def reset
      @stack.clear
      @queue.clear
      self
    end

    ##
    # @return [Machine]
    def halt
      @queue.clear
      self
    end

    ##
    # @return [Machine]
    def nop
      self # do nothing
    end
    alias_method :',', :nop
    alias_method :';', :nop

    ##
    # @return [Machine]
    def quote
      push([shift])
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
      with_saved_continuation(:times) do
        case quot
          when Array
            count.to_i.times { unshift(quot, :call) }
          when Symbol
            count.to_i.times { unshift([quot], :call) } # FIXME
          else # TODO: error
        end
      end
    end

    ##
    # @return [Machine]
    def twice(quot)
      with_saved_continuation(:twice) do
        case quot
          when Array
            2.times { unshift(quot, :call) }
          when Symbol
            2.times { unshift([quot], :call) } # FIXME
          else # TODO: error
        end
      end
    end
    alias_method :'2x', :twice

    ##
    # @return [Machine]
    def thrice(quot)
      with_saved_continuation(:thrice) do
        case quot
          when Array
            3.times { unshift(quot, :call) }
          when Symbol
            3.times { unshift([quot], :call) } # FIXME
          else # TODO: error
        end
      end
    end
    alias_method :'3x', :thrice

    ##
    # @return [Machine]
    def loop(quot)
      case quot
        when Array
          unshift(quot, :call, quot, :loop)
        when Symbol
          unshift(quot, [quot], :loop) # FIXME
        else # TODO: error
      end
      self
    end

    ##
    # @return [Machine]
    def while(quot, cond)
      with_saved_continuation(:while) do
        Kernel.loop do # FIXME
          execute(cond)
          case pop
            when false, nil then break
            else execute(quot)
          end
        end
      end
    end

    ##
    # @return [Machine]
    def until(quot, cond)
      with_saved_continuation(:until) do
        Kernel.loop do # FIXME
          execute(cond)
          case pop
            when false, nil then execute(quot)
            else break
          end
        end
      end
    end

    ##
    # @return [Machine]
    def branch(cond, thenop, elseop)
      case cond
        when false, nil then unshift(elseop, :call)
        else unshift(thenop, :call)
      end
      self
    end
    alias_method :if, :branch

    ##
    # @return [Machine]
    def when(cond, quot)
      case cond
        when false, nil then # nop
        else unshift(quot, :call)
      end
      self
    end

    ##
    # @return [Machine]
    def unless(cond, quot)
      case cond
        when false, nil then unshift(quot, :call)
        else # nop
      end
      self
    end
  end # module Execution
end; end # module Trith::Core
