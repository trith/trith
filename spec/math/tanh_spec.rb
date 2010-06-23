require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:tanh" do
  it "is implemented" do
    Machine.new.should respond_to(:tanh)
  end

  it "requires one operand" do
    lambda { Machine.run([:tanh]) }.should underflow_stack
    lambda { Machine.run([nil, :tanh]) }.should_not underflow_stack
  end
end
