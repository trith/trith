require 'trith'
include Trith

module Trith
  module Spec
    module Matchers
      def self.define(name, &declarations)
        define_method name do |*expected|
          ::Spec::Matchers::Matcher.new(name, *expected, &declarations)
        end
      end

      define :underflow_stack do
        match do |proc|
          proc.should raise_error(Machine::StackUnderflowError)
        end
      end
    end
  end
end

Spec::Runner.configure do |config|
  config.include(Trith::Spec::Matchers)
end
