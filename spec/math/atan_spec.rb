require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:atan" do
  it "is implemented" do
    Machine.new.should respond_to(:atan)
  end

  it "requires one operand" do
    lambda { Machine.run([:atan]) }.should underflow_stack
    lambda { Machine.run([nil, :atan]) }.should_not underflow_stack
  end
end
