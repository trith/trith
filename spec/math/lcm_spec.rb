require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:lcm" do
  it "is implemented" do
    Machine.new.should respond_to(:lcm)
  end

  it "requires two operands" do
    lambda { Machine.run([:lcm]) }.should underflow_stack
    lambda { Machine.run([nil, :lcm]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :lcm]) }.should_not underflow_stack
  end
end
