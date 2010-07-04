require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cosh" do
  it "is implemented" do
    Machine.new.should respond_to(:cosh)
  end

  it "requires one operand" do
    lambda { Machine.run([:cosh]) }.should underflow_stack
    lambda { Machine.run([nil, :cosh]) }.should_not underflow_stack
  end
end
