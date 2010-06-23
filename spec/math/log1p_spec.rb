require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:log1p" do
  it "is implemented" do
    Machine.new.should respond_to(:log1p)
  end

  it "requires two operands" do
    lambda { Machine.run([:log1p]) }.should underflow_stack
    lambda { Machine.run([nil, :log1p]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :log1p]) }.should_not underflow_stack
  end
end
