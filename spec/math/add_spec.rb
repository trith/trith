require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:add" do
  it "is implemented" do
    Machine.new.should respond_to(:add, :+)
  end

  it "requires two operands" do
    lambda { Machine.run([:add]) }.should underflow_stack
    lambda { Machine.run([nil, :add]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :add]) }.should_not underflow_stack
  end
end
