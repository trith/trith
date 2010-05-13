module Trith; module Shell
  ##
  module History
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
    # Does not append empty lines or duplicates, and works around libedit
    # issues where needed.
    #
    # @param  [String] line
    # @return [void]
    def self.push(line)
      unless line =~ /^\s$/ || Readline::HISTORY.include?(line)
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
    # Returns an array representation of the shell history.
    #
    # @return [Array<String>]
    def self.to_a
      Readline::HISTORY.to_a
    end
  end # module History
end; end # module Trith::Shell
