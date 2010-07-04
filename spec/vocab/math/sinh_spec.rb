require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sinh" do
  it "is implemented" do
    Machine.new.should respond_to(:sinh)
  end

  it "requires one operand" do
    lambda { Machine.run([:sinh]) }.should underflow_stack
    lambda { Machine.run([nil, :sinh]) }.should_not underflow_stack
  end
end
