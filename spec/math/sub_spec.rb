require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sub" do
  it "is implemented" do
    Machine.new.should respond_to(:sub, :-)
  end
end
