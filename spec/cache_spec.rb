require File.join(File.dirname(__FILE__), 'spec_helper')

describe Trith::Cache do
  before :each do
    @cache = Trith::Cache.load(File.join(File.dirname(__FILE__), '..', 'etc', 'cache.nt'))
  end

  it "should be an RDF repository" do
    @cache.should be_an(RDF::Repository)
  end

  it "should know whether a given function is cached" do
    @cache.should respond_to(:has_function?)
    @cache.has_function?(RDF::URI("http://trith.org/core/dup")).should be_true
    @cache.has_function?(RDF::URI("http://example.org/myfunction")).should be_false
    @cache.has_function?(RDF::Node.new).should be_false
    @cache.has_function?(Trith::Function.new("http://trith.org/core/dup")).should be_true
    @cache.has_function?(Trith::Function.new).should be_false
  end

  it "should enumerate the cached functions" do
    @cache.should respond_to(:each_function)
    @cache.each_function do |function|
      function.should be_a(Trith::Function)
    end
    @cache.each_function.should be_a(RDF::Enumerator)
  end

  it "should find cached functions by their labels" do
    @cache.should respond_to(:find_functions)
    @cache.find_functions do |function|
      function.should be_a(Trith::Function)
    end
    @cache.find_functions.should be_a(RDF::Enumerator)
    @cache.find_functions(:label => :dup).to_a.size.should == 1
  end
end
