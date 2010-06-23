require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:neg" do
  it "is implemented" do
    Machine.new.should respond_to(:neg)
  end

  it "requires one operand" do
    lambda { Machine.run([:neg]) }.should underflow_stack
    lambda { Machine.run([nil, :neg]) }.should_not underflow_stack
  end
end
