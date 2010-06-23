require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:acos" do
  it "is implemented" do
    Machine.new.should respond_to(:acos)
  end

  it "requires one operand" do
    lambda { Machine.run([:acos]) }.should underflow_stack
    lambda { Machine.run([nil, :acos]) }.should_not underflow_stack
  end
end
