require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:neg" do
  it "is implemented" do
    Machine.new.should respond_to(:neg)
  end
end
