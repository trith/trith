require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:tanh" do
  it "is implemented" do
    Machine.new.should respond_to(:tanh)
  end
end
