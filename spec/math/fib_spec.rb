require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:fib" do
  it "is implemented" do
    Machine.new.should respond_to(:fib)
  end

  it "requires one operand" do
    lambda { Machine.run([:fib]) }.should underflow_stack
    lambda { Machine.run([nil, :fib]) }.should_not underflow_stack
  end
end
