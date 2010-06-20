require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:ceil" do
  it "is implemented" do
    Machine.new.should respond_to(:ceil)
  end
end
