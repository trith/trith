require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:mul" do
  it "is implemented" do
    Machine.new.should respond_to(:mul, :*)
  end

  it "requires two operands" do
    lambda { Machine.run([:mul]) }.should underflow_stack
    lambda { Machine.run([nil, :mul]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :mul]) }.should_not underflow_stack
  end
end
