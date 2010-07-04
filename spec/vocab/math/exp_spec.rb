require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:exp" do
  it "is implemented" do
    Machine.new.should respond_to(:exp)
  end

  it "requires one operand" do
    lambda { Machine.run([:exp]) }.should underflow_stack
    lambda { Machine.run([nil, :exp]) }.should_not underflow_stack
  end
end
