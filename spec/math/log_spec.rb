require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:log" do
  it "is implemented" do
    Machine.new.should respond_to(:log)
  end

  it "requires two operands" do
    lambda { Machine.run([:log]) }.should underflow_stack
    lambda { Machine.run([nil, :log]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :log]) }.should_not underflow_stack
  end
end
