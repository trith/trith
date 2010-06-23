require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:abs" do
  it "is implemented" do
    Machine.new.should respond_to(:abs)
  end

  it "requires one operand" do
    lambda { Machine.run([:abs]) }.should underflow_stack
    lambda { Machine.run([nil, :abs]) }.should_not underflow_stack
  end

  it "returns a number"
  it "returns the absolute magnitude of the operand"
end
