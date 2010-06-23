require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:mod" do
  it "is implemented" do
    Machine.new.should respond_to(:mod)
  end

  it "requires two operands" do
    lambda { Machine.run([:mod]) }.should underflow_stack
    lambda { Machine.run([nil, :mod]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :mod]) }.should_not underflow_stack
  end
end
