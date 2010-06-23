require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:pow" do
  it "is implemented" do
    Machine.new.should respond_to(:pow)
  end

  it "requires two operands" do
    lambda { Machine.run([:pow]) }.should underflow_stack
    lambda { Machine.run([nil, :pow]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :pow]) }.should_not underflow_stack
  end
end
