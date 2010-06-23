require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:inc" do
  it "is implemented" do
    Machine.new.should respond_to(:inc)
  end

  it "requires one operand" do
    lambda { Machine.run([:inc]) }.should underflow_stack
    lambda { Machine.run([nil, :inc]) }.should_not underflow_stack
  end
end
