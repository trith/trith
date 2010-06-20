require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:tan" do
  it "is implemented" do
    Machine.new.should respond_to(:tan)
  end
end
