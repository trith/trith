require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:cb" do
  it "is implemented" do
    Machine.new.should respond_to(:cb)
  end
end
