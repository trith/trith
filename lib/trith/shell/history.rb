module Trith; module Shell
  ##
  # Supporting code for the `3sh` shell's input line history.
  module History
    FILE = File.join(ENV['TRITH_HOME'] || '~', '.trith', '3sh.log').freeze unless const_defined?(:FILE)
    MODE = 0640

    ##
    # Loads the shell history from the `~/.trith/3sh.log` file.
    #
    # @return [void]
    def self.load!
      unless (lines = File.readlines(File.expand_path(FILE)) rescue []).empty?
        Readline::HISTORY.push(*lines.map { |line| line.chomp.strip })
        @load_count = Readline::HISTORY.size
      end
    end

    ##
    # Dumps the shell history to the `~/.trith/3sh.log` file.
    #
    # @return [void]
    def self.dump!
      File.open(File.expand_path(FILE), 'a', MODE) do |file|
        lines = Readline::HISTORY.to_a
        lines.slice!(0, @load_count) if @load_count
        file.puts(lines)
      end
    end

    ##
    # Returns `true` if the shell history is empty.
    #
    # @return [Boolean]
    def self.empty?
      Readline::HISTORY.empty?
    end

    ##
    # Returns `true` if the shell history includes `line`.
    #
    # @param  [String] line
    # @return [Boolean]
    def self.include?(line)
      Readline::HISTORY.include?(line)
    end

    ##
    # Appends `line` to the shell history.
    #
    # Does not append empty lines or consecutive duplicates, and works
    # around implementation-specific issues where needed.
    #
    # @param  [String] line
    # @return [void]
    def self.push(line)
      unless line =~ /^\s$/ || line == peek
        Readline::HISTORY.push(line)

        # This is a workaround for a libedit-related bug encountered with
        # the default Ruby versions shipped with Mac OS X.
        # @see http://bogojoker.com/readline/#libedit_history_issue
        unless Readline::HISTORY.include?(line)
          Readline::HISTORY.push(line)
        end
      end
    end

    ##
    # Returns the most recent line from the shell history.
    #
    # @return [String]
    def self.peek
      case
        when Readline::HISTORY.respond_to?(:peek)
          Readline::HISTORY.peek
        when Readline::HISTORY.respond_to?(:last)
          Readline::HISTORY.last
        else
          Readline::HISTORY.to_a.last
      end
    end

    ##
    # Returns an array representation of the shell history.
    #
    # @return [Array<String>]
    def self.to_a
      Readline::HISTORY.to_a
    end
  end # module History
end; end # module Trith::Shell
