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
  end
end
