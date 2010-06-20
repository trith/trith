require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:mod" do
  it "is implemented" do
    Machine.new.should respond_to(:mod)
  end
end
