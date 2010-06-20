require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:floor" do
  it "is implemented" do
    Machine.new.should respond_to(:floor)
  end
end
