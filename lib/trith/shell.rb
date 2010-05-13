module Trith
  ##
  # Supporting code for the `3sh` shell.
  module Shell
    autoload :History, 'trith/shell/history'

    ##
    # Initializes shell functionality and the Readline library.
    #
    # @param  [Trith::Cache] cache
    # @return [void]
    def self.setup!(cache)
      require 'readline' unless defined?(Readline)
      Readline.completion_append_character = ' '
      Readline.completion_proc = completion_proc(cache)
    end

    ##
    # Reads and returns a line of input from the terminal.
    #
    # @param  [String] prompt
    # @return [String]
    def self.readline(prompt)
      Readline.readline(prompt)
    end

    ##
    # Returns an input completion proc for use with Readline.
    #
    # @param  [Trith::Cache] cache
    # @return [Proc]
    # @see    http://bogojoker.com/readline/
    def self.completion_proc(cache)
      # TODO: optimize this once RDF::Queryable supports #query([s, p, /o/])
      proc do |s|
        candidates = []
        cache.each_function do |function|
          function.labels.each do |label|
            candidates << label.to_s if label.to_s.start_with?(s)
          end
        end
        candidates.uniq
      end
    end
  end # module Shell
end # module Trith
