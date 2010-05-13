module Trith
  ##
  # Supporting code for `3sh`.
  module Shell
    autoload :History, 'trith/shell/history'

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
