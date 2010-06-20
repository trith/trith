require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:inc" do
  it "is implemented" do
    Machine.new.should respond_to(:inc)
  end
end
