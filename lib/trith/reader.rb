module Trith
  ##
  # The Trith code parser.
  #
  # @see http://sxp.rubyforge.org/
  class Reader
    ##
    # @param  [String, #to_s]          url
    # @param  [Hash{Symbol => Object}] options
    # @return [Enumerable<Object>]
    def self.read_url(url, options = {})
      SXP.read_uri(url.to_s)
    end

    ##
    # @param  [Enumerable<String>]     filenames
    # @param  [Hash{Symbol => Object}] options
    # @return [Enumerable<Object>]
    def self.read_files(*filenames)
      options = filenames.last.is_a?(Hash) ? filenames.pop : {}
      SXP.read_files(*filenames) # FIXME
    end

    ##
    # @param  [String, #to_s]          filename
    # @param  [Hash{Symbol => Object}] options
    # @return [Enumerable<Object>]
    def self.read_file(filename, options = {})
      SXP.read_file(filename.to_s)
    end

    ##
    # @param  [IO, StringIO, String]   input
    # @param  [Hash{Symbol => Object}] options
    # @return [Enumerable<Object>]
    def self.read_all(input, options = {})
      SXP.read_all(input)
    end

    ##
    # @param  [IO, StringIO, String]   input
    # @param  [Hash{Symbol => Object}] options
    # @return [Object]
    def self.read(input, options = {})
      SXP.read(input)
    end

    # Prevent the instantiation of this class:
    private_class_method :new
  end # class Reader
end # module Trith
