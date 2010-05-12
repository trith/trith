require File.join(File.dirname(__FILE__), 'spec_helper')

describe Trith::Function do
  before :each do
    @fn = Trith::Function.new
  end

  it "should have an RDF representation" do
    @fn.should respond_to(:to_rdf)
    @fn.to_rdf.should be_an(RDF::Graph)
  end
end
