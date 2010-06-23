require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:div" do
  it "is implemented" do
    Machine.new.should respond_to(:div, :'/')
  end

  it "requires two operands" do
    lambda { Machine.run([:div]) }.should underflow_stack
    lambda { Machine.run([nil, :div]) }.should underflow_stack
    lambda { Machine.run([nil, nil, :div]) }.should_not underflow_stack
  end
end
