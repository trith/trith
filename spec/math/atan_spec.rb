require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:atan" do
  it "is implemented" do
    Machine.new.should respond_to(:atan)
  end
end
