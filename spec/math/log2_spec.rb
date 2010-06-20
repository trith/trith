require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:log2" do
  it "is implemented" do
    Machine.new.should respond_to(:log2)
  end
end
