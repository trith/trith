module Trith; module Shell
  ##
  module Inspect
    ##
    # Escape codes for colored shell output.
    module Color
      NOTHING      = "\033[0;0m".freeze
      BLACK        = "\033[0;30m".freeze
      RED          = "\033[0;31m".freeze
      GREEN        = "\033[0;32m".freeze
      BROWN        = "\033[0;33m".freeze
      BLUE         = "\033[0;34m".freeze
      PURPLE       = "\033[0;35m".freeze
      CYAN         = "\033[0;36m".freeze
      LIGHT_GRAY   = "\033[0;37m".freeze
      DARK_GRAY    = "\033[1;30m".freeze
      LIGHT_RED    = "\033[1;31m".freeze
      LIGHT_GREEN  = "\033[1;32m".freeze
      YELLOW       = "\033[1;33m".freeze
      LIGHT_BLUE   = "\033[1;34m".freeze
      LIGHT_PURPLE = "\033[1;35m".freeze
      LIGHT_CYAN   = "\033[1;36m".freeze
      WHITE        = "\033[1;37m".freeze

      # Freeze all color escape strings:
      constants.each do |color|
        color.force_encoding(Encoding::ASCII) if color.respond_to?(:force_encoding)
        color.freeze
      end
    end

    ##
    # @param  [String, #to_s] text
    # @param  [Symbol, #to_s] color
    # @return [String]
    def self.colorize(text, color)
      !color ? text.to_s : [(Color.const_get(color.to_s.upcase) rescue nil), text.to_s, Color::NOTHING].join('')
    end

    ##
    # @param  [Object]                 value
    # @param  [Hash{Symbol => Object}] options
    # @return [String]
    def self.inspect(value, options = {})
      case value
        when NilClass   then colorize(:nil, options[:color] ? :green : nil)
        when FalseClass then colorize(false, options[:color] ? :green : nil)
        when TrueClass  then colorize(true, options[:color] ? :green : nil)
        when Symbol     then colorize(value.to_s, options[:color] ? :yellow : nil)
        when Numeric    then colorize(value.inspect, options[:color] ? :cyan : nil)
        when String     then inspect_string(value, options)
        when Array      then inspect_array(value, options)
        when RDF::URI   then inspect_reference(value, options)
        when Machine    then inspect_machine(value, options)
        else value.inspect
      end
    end

    ##
    # @param  [Machine]                machine
    # @param  [Hash{Symbol => Object}] options
    # @return [String]
    def self.inspect_machine(machine, options = {})
      (options[:prefix].to_s || '') +
        (options[:align] ? ' ' * [20 - inspect(machine.stack, :color => false).size, 0].max : '') +
        inspect(machine.stack, options) + ' : ' +
        inspect(machine.queue, options)
    end

    ##
    # @param  [Array, #to_ary]         array
    # @param  [Hash{Symbol => Object}] options
    # @return [String]
    def self.inspect_array(array, options = {})
      colorize('[', options[:color] ? :green : nil) <<
      array.to_ary.map { |element| inspect(element, options) }.join(' ') <<
      colorize(']', options[:color] ? :green : nil)
    end

    ##
    # @param  [String, #to_str]        string
    # @param  [Hash{Symbol => Object}] options
    # @return [String]
    def self.inspect_string(string, options = {})
      colorize('"', options[:color] ? :red : nil) <<
      colorize(string.to_str.inspect[1...-1], options[:color] ? :cyan : nil) <<
      colorize('"', options[:color] ? :red : nil)
    end

    ##
    # @param  [RDF::URI, #to_uri]      uri
    # @param  [Hash{Symbol => Object}] options
    # @return [String]
    def self.inspect_reference(uri, options = {})
      colorize('<', options[:color] ? :red : nil) <<
      colorize(uri.to_uri.to_s, options[:color] ? :cyan : nil) <<
      colorize('>', options[:color] ? :red : nil)
    end
  end # module Color
end; end # module Trith::Shell
