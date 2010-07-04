require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cbrt" do
  it "is implemented" do
    Machine.new.should respond_to(:cbrt)
  end

  it "requires one operand" do
    lambda { Machine.run([:cbrt]) }.should underflow_stack
    lambda { Machine.run([nil, :cbrt]) }.should_not underflow_stack
  end
end
