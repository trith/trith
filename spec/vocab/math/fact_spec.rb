require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:fact" do
  it "is implemented" do
    Machine.new.should respond_to(:fact)
  end

  it "requires one operand" do
    lambda { Machine.run([:fact]) }.should underflow_stack
    lambda { Machine.run([nil, :fact]) }.should_not underflow_stack
  end
end
