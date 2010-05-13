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
    # Returns a symbol indicating which Readline library this Ruby
    # implementation uses.
    #
    # The possible return values are `:readline`, `:libedit` and `:jruby`.
    #
    # The default Ruby versions shipped with Mac OS X use `:libedit` as
    # their Readline library and have buggy functionality that needs to be
    # worked around.
    #
    # @return [Symbol]
    # @see    http://bogojoker.com/readline/#libedit_detection
    def self.readline_library
      case RUBY_PLATFORM.to_sym
        when :java
          RUBY_ENGINE.to_sym rescue :jruby   # JRuby 1.4.x/1.5.x
        else
          begin                              # Ruby with `readline`
            Readline.emacs_editing_mode
            :readline
          rescue NotImplementedError         # Ruby with `libedit` (Mac OS X)
            :libedit
          end
      end
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
