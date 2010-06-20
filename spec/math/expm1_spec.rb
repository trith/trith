require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:expm1" do
  it "is implemented" do
    Machine.new.should respond_to(:expm1)
  end
end
