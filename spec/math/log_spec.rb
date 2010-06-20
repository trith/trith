require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:log" do
  it "is implemented" do
    Machine.new.should respond_to(:log)
  end
end
