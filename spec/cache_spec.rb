require File.join(File.dirname(__FILE__), 'spec_helper')

describe Trith::Cache do
  before :each do
    @cache = Trith::Cache.new
  end

  it "should be an RDF repository" do
    @cache.should be_an(RDF::Repository)
  end
end
