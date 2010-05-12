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
    @cache.should have_function(Trith::Function.new("http://trith.org/core/dup"))
    @cache.should have_function(RDF::URI("http://trith.org/core/dup"))
    @cache.should_not have_function(Trith::Function.new)
    @cache.should_not have_function(RDF::URI("http://example.org/myfunction"))
    @cache.should_not have_function(RDF::Node.new)
  end

  it "should know whether a function with a given label is cached" do
    @cache.should respond_to(:has_label?)
    @cache.should have_label(:boolean?)
    @cache.should_not have_label(:foobar)
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
