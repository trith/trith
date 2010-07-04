require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sign" do
  it "is implemented" do
    Machine.new.should respond_to(:sign)
  end

  it "requires one operand" do
    lambda { Machine.run([:sign]) }.should underflow_stack
    lambda { Machine.run([nil, :sign]) }.should_not underflow_stack
  end
end
