require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:floor" do
  it "is implemented" do
    Machine.new.should respond_to(:floor)
  end

  it "requires one operand" do
    lambda { Machine.run([:floor]) }.should underflow_stack
    lambda { Machine.run([nil, :floor]) }.should_not underflow_stack
  end
end
