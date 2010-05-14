module Trith
  ##
  # The Trith core operators.
  module Core
    # TODO

    # Include all submodule methods directly into Trith::Core:
    constants.each { |mod| include(const_get(mod)) }
  end # module Core
end # module Trith
