require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:rem" do
  it "is implemented" do
    Machine.new.should respond_to(:rem)
  end

  it "requires two operands" do
    lambda { Machine.run([:rem]) }.should underflow_stack
    lambda { Machine.run([nil, :rem]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :rem]) }.should_not underflow_stack
  end
end
