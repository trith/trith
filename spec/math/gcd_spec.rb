require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:gcd" do
  it "is implemented" do
    Machine.new.should respond_to(:gcd)
  end

  it "requires two operands" do
    lambda { Machine.run([:gcd]) }.should underflow_stack
    lambda { Machine.run([nil, :gcd]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :gcd]) }.should_not underflow_stack
  end
end
