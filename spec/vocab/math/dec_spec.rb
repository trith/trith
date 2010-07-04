require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:dec" do
  it "is implemented" do
    Machine.new.should respond_to(:dec)
  end

  it "requires one operand" do
    lambda { Machine.run([:dec]) }.should underflow_stack
    lambda { Machine.run([nil, :dec]) }.should_not underflow_stack
  end
end
