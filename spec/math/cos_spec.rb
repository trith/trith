require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cos" do
  it "is implemented" do
    Machine.new.should respond_to(:cos)
  end
end
