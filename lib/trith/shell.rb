module Trith
  ##
  # Supporting code for the `3sh` shell.
  module Shell
    autoload :History, 'trith/shell/history'
    autoload :Inspect, 'trith/shell/inspect'

    ##
    # Initializes shell functionality and the Readline library.
    #
    # @param  [Trith::Cache] cache
    # @return [void]
    def self.setup!(cache)
      require 'readline' unless defined?(Readline)
      Readline.completion_proc = completion_proc(cache)
    end

    ##
    # Returns a developer-friendly representation of `value`.
    #
    # @param  [Object] value
    # @return [String]
    def self.inspect(value)
      Inspect.inspect(value)
    end

    ##
    # Reads and returns a line of input from the terminal.
    #
    # @param  [String] prompt
    # @return [String]
    # @see    http://bogojoker.com/readline/
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
      @readline_library ||= case RUBY_PLATFORM.to_sym
        when :java
          RUBY_ENGINE.to_sym rescue :jruby   # JRuby 1.4.x/1.5.x
        else
          begin                              # Ruby with `readline`
            Readline.emacs_editing_mode
            :readline
          rescue NotImplementedError         # Ruby with `libedit` (Mac OS X)
            :libedit
          rescue
            :libedit                         # just to be on the safe side
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
      Readline.completion_append_character = ' ' unless broken_append_character?
      proc do |prefix|
        candidates = []
        # TODO: optimize this once RDF::Queryable supports #query([s, p, /o/])
        cache.each_function do |function|
          function.labels.each do |label|
            candidates << label.to_s if label.to_s.start_with?(prefix)
          end
        end
        candidates.map! { |candidate| candidate << ' ' } if broken_append_character?
        candidates.uniq
      end
    end

    protected

    ##
    # Returns `true` if the first call to `Readline::HISTORY.push` is broken
    # on this Ruby implementation.
    #
    # This is a `libedit`-related bug encountered with the default Ruby
    # versions shipped with Mac OS X.
    #
    # @return [Boolean]
    # @see    http://bogojoker.com/readline/#libedit_history_issue
    def self.broken_initial_history?
      readline_library == :libedit
    end

    ##
    # Returns `true` if `Readline.completion_append_character` is broken on
    # this Ruby implementation.
    #
    # The feature in question is currently broken on Ruby with `libedit` and
    # just unimplemented on JRuby 1.4.x/1.5.x
    #
    # @return [Boolean]
    # @see    http://bogojoker.com/readline/#libedit_completion_append_character_issue
    def self.broken_append_character?
      [:libedit, :jruby].include?(readline_library)
    end
  end # module Shell
end # module Trith
