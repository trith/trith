require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:rand" do
  it "is implemented" do
    Machine.new.should respond_to(:rand)
  end

  it "requires no operands" do
    lambda { Machine.run([:rand]) }.should_not underflow_stack
  end
end
