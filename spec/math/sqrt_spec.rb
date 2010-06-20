require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sqrt" do
  it "is implemented" do
    Machine.new.should respond_to(:sqrt)
  end
end
