require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:mul" do
  it "is implemented" do
    Machine.new.should respond_to(:mul, :*)
  end
end
