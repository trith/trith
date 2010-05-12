module Trith
  ##
  # The Trith code cache.
  class Cache < RDF::Repository
    include RDF::Repository::Implementation rescue nil

    ##
    # @param  [Array<String>] filenames
    # @return [Trith::Cache]
    def self.load(*filenames)
      self.new do |repository|
        filenames.each do |filename|
          repository.load(filename)
        end
      end
    end

    ##
    # @param  [Hash{Symbol => Object} options
    def initialize(options = {}, &block)
      @data = []
      super(options, &block)
    end

    ##
    # Enumerates each function in the cache.
    #
    # @return [Enumerator<Trith::Function>]
    def each_function(&block)
      unless block_given?
        Enumerator.new(self, :each_function)
      else
        query(:predicate => RDF.type, :object => Trith::Function::URI) do |statement|
          block.call(Trith::Function.new(statement.subject))
        end
      end
    end
  end
end
