require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:ceil" do
  it "is implemented" do
    Machine.new.should respond_to(:ceil)
  end

  it "requires one operand" do
    lambda { Machine.run([:ceil]) }.should underflow_stack
    lambda { Machine.run([nil, :ceil]) }.should_not underflow_stack
  end
end
