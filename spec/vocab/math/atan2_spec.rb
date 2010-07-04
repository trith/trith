require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:atan2" do
  it "is implemented" do
    Machine.new.should respond_to(:atan2)
  end

  it "requires two operands" do
    lambda { Machine.run([:atan2]) }.should underflow_stack
    lambda { Machine.run([nil, :atan2]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :atan2]) }.should_not underflow_stack
  end
end
