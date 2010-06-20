require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:rem" do
  it "is implemented" do
    Machine.new.should respond_to(:rem)
  end
end
