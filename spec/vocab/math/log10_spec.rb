require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:log10" do
  it "is implemented" do
    Machine.new.should respond_to(:log10)
  end

  it "requires one operand" do
    lambda { Machine.run([:log10]) }.should underflow_stack
    lambda { Machine.run([nil, :log10]) }.should_not underflow_stack
  end
end
