require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:asin" do
  it "is implemented" do
    Machine.new.should respond_to(:asin)
  end

  it "requires one operand" do
    lambda { Machine.run([:asin]) }.should underflow_stack
    lambda { Machine.run([nil, :asin]) }.should_not underflow_stack
  end
end
