require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sqrt" do
  it "is implemented" do
    Machine.new.should respond_to(:sqrt)
  end

  it "requires one operand" do
    lambda { Machine.run([:sqrt]) }.should underflow_stack
    lambda { Machine.run([nil, :sqrt]) }.should_not underflow_stack
  end
end
