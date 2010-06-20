require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cosh" do
  it "is implemented" do
    Machine.new.should respond_to(:cosh)
  end
end
