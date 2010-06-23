require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:round" do
  it "is implemented" do
    Machine.new.should respond_to(:round)
  end

  it "requires two operands" do
    lambda { Machine.run([:round]) }.should underflow_stack
    lambda { Machine.run([nil, :round]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :round]) }.should_not underflow_stack
  end
end
