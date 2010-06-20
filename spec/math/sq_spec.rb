require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "math:sq" do
  it "is implemented" do
    Machine.new.should respond_to(:sq)
  end
end
