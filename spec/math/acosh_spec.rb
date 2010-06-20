require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:acosh" do
  it "is implemented" do
    Machine.new.should respond_to(:acosh)
  end
end
