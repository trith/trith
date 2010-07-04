require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cb" do
  it "is implemented" do
    Machine.new.should respond_to(:cb)
  end

  it "requires one operand" do
    lambda { Machine.run([:cb]) }.should underflow_stack
    lambda { Machine.run([nil, :cb]) }.should_not underflow_stack
  end
end
