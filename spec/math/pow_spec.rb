require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:pow" do
  it "is implemented" do
    Machine.new.should respond_to(:pow)
  end
end
