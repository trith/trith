require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cbrt" do
  it "is implemented" do
    Machine.new.should respond_to(:cbrt)
  end
end
