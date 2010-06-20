require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:gcd" do
  it "is implemented" do
    Machine.new.should respond_to(:gcd)
  end
end
