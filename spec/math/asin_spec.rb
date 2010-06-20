require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:asin" do
  it "is implemented" do
    Machine.new.should respond_to(:asin)
  end
end
