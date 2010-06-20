require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:hypot" do
  it "is implemented" do
    Machine.new.should respond_to(:hypot)
  end
end
