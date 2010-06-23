require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:pi" do
  it "is implemented" do
    Machine.new.should respond_to(:pi)
  end

  it "requires no operands" do
    lambda { Machine.run([:pi]) }.should_not underflow_stack
  end
end
