require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:abs" do
  it "is implemented" do
    Machine.new.should respond_to(:abs)
  end

  it "returns a number"
  it "returns the absolute magnitude of the argument"
end
