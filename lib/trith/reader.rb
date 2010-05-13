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
      SXP.read_url(url, options)
    end

    ##
    # @param  [Enumerable<String>]     filenames
    # @param  [Hash{Symbol => Object}] options
    # @return [Enumerable<Object>]
    def self.read_files(*filenames)
      SXP.read_files(*filenames)
    end

    ##
    # @param  [String, #to_s]          filename
    # @param  [Hash{Symbol => Object}] options
    # @return [Enumerable<Object>]
    def self.read_file(filename, options = {})
      SXP.read_file(filename, options)
    end

    ##
    # @param  [IO, StringIO, String]   input
    # @param  [Hash{Symbol => Object}] options
    # @return [Enumerable<Object>]
    def self.read_all(input, options = {})
      SXP.read_all(input, options)
    end

    ##
    # @param  [IO, StringIO, String]   input
    # @param  [Hash{Symbol => Object}] options
    # @return [Object]
    def self.read(input, options = {})
      SXP.read(input, options)
    end

    # Prevent the instantiation of this class:
    private_class_method :new
  end # class Reader
end # module Trith
