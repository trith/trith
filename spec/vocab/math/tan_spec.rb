require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:tan" do
  it "is implemented" do
    Machine.new.should respond_to(:tan)
  end

  it "requires one operand" do
    lambda { Machine.run([:tan]) }.should underflow_stack
    lambda { Machine.run([nil, :tan]) }.should_not underflow_stack
  end
end
