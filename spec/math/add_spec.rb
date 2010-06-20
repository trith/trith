require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:add" do
  it "is implemented" do
    Machine.new.should respond_to(:add, :+)
  end
end
