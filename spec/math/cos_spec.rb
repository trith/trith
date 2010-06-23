require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cos" do
  it "is implemented" do
    Machine.new.should respond_to(:cos)
  end

  it "requires one operand" do
    lambda { Machine.run([:cos]) }.should underflow_stack
    lambda { Machine.run([nil, :cos]) }.should_not underflow_stack
  end
end
