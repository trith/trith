require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:log2" do
  it "is implemented" do
    Machine.new.should respond_to(:log2)
  end

  it "requires one operand" do
    lambda { Machine.run([:log2]) }.should underflow_stack
    lambda { Machine.run([nil, :log2]) }.should_not underflow_stack
  end
end
