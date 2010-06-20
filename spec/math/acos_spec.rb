require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:acos" do
  it "is implemented" do
    Machine.new.should respond_to(:acos)
  end
end
