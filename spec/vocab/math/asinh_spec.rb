require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:asinh" do
  it "is implemented" do
    Machine.new.should respond_to(:asinh)
  end

  it "requires one operand" do
    lambda { Machine.run([:asinh]) }.should underflow_stack
    lambda { Machine.run([nil, :asinh]) }.should_not underflow_stack
  end
end
