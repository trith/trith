require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:dec" do
  it "is implemented" do
    Machine.new.should respond_to(:dec)
  end
end
