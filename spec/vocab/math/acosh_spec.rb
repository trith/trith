require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:acosh" do
  it "is implemented" do
    Machine.new.should respond_to(:acosh)
  end

  it "requires one operand" do
    lambda { Machine.run([:acosh]) }.should underflow_stack
    lambda { Machine.run([nil, :acosh]) }.should_not underflow_stack
  end
end
