require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:fact" do
  it "is implemented" do
    Machine.new.should respond_to(:fact)
  end
end
