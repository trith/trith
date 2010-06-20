require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sign" do
  it "is implemented" do
    Machine.new.should respond_to(:sign)
  end
end
