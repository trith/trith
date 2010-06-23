require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sub" do
  it "is implemented" do
    Machine.new.should respond_to(:sub, :-)
  end

  it "requires two operands" do
    lambda { Machine.run([:sub]) }.should underflow_stack
    lambda { Machine.run([nil, :sub]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :sub]) }.should_not underflow_stack
  end
end
