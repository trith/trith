require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:exp" do
  it "is implemented" do
    Machine.new.should respond_to(:exp)
  end
end
