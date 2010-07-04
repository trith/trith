require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sq" do
  it "is implemented" do
    Machine.new.should respond_to(:sq)
  end

  it "requires one operand" do
    lambda { Machine.run([:sq]) }.should underflow_stack
    lambda { Machine.run([nil, :sq]) }.should_not underflow_stack
  end
end
