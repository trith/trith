require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:asinh" do
  it "is implemented" do
    Machine.new.should respond_to(:asinh)
  end
end
