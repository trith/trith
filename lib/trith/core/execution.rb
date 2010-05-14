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
    def call
      # TODO
    end

    ##
    # @return [Machine]
    def loop
      # TODO
    end

    ##
    # @return [Machine]
    def branch
      # TODO
    end
  end # module Execution
end; end # module Trith::Core
