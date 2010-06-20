require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:pi" do
  it "is implemented" do
    Machine.new.should respond_to(:pi)
  end
end
