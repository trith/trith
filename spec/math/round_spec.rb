require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:round" do
  it "is implemented" do
    Machine.new.should respond_to(:round)
  end
end
