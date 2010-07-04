require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:hypot" do
  it "is implemented" do
    Machine.new.should respond_to(:hypot)
  end

  it "requires two operands" do
    lambda { Machine.run([:hypot]) }.should underflow_stack
    lambda { Machine.run([nil, :hypot]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :hypot]) }.should_not underflow_stack
  end
end
