require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:atanh" do
  it "is implemented" do
    Machine.new.should respond_to(:atanh)
  end

  it "requires one operand" do
    lambda { Machine.run([:atanh]) }.should underflow_stack
    lambda { Machine.run([nil, :atanh]) }.should_not underflow_stack
  end
end
