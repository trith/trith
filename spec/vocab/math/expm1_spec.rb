require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:expm1" do
  it "is implemented" do
    Machine.new.should respond_to(:expm1)
  end

  it "requires one operand" do
    lambda { Machine.run([:expm1]) }.should underflow_stack
    lambda { Machine.run([nil, :expm1]) }.should_not underflow_stack
  end
end
