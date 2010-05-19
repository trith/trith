module Trith; module Core
  ##
  # Output operators.
  module Output
    ##
    # @return [Machine]
    def print(obj)
      $stdout.puts(obj) # FIXME
      self
    end
    alias_method :print!, :print
    alias_method :'.',    :print
  end # module Output
end; end # module Trith::Core
