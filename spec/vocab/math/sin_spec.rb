require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sin" do
  it "is implemented" do
    Machine.new.should respond_to(:sin)
  end

  it "requires one operand" do
    lambda { Machine.run([:sin]) }.should underflow_stack
    lambda { Machine.run([nil, :sin]) }.should_not underflow_stack
  end
end
