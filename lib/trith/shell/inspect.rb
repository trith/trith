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
    # @param  [Object] value
    # @return [String]
    def self.inspect(value)
      case value
        when Array      then colorize_array(value)
        when NilClass   then colorize(:nil, :green)
        when FalseClass then colorize(false, :green)
        when TrueClass  then colorize(true, :green)
        when Symbol     then colorize(value.to_s, :yellow)
        when Numeric    then colorize(value.inspect, :cyan)
        when String     then colorize_string(value)
        when RDF::URI   then colorize_reference(value)
        else value.inspect
      end
    end

    ##
    # @param  [Array, #to_ary] array
    # @return [String]
    def self.colorize_array(array)
      colorize('[', :green) <<
      array.to_ary.map { |element| inspect(element) }.join(' ') <<
      colorize(']', :green)
    end

    ##
    # @param  [String, #to_str] string
    # @return [String]
    def self.colorize_string(string)
      colorize('"', :red) <<
      colorize(string.to_str.inspect[1...-1], :cyan) <<
      colorize('"', :red)
    end

    ##
    # @param  [RDF::URI, #to_uri] uri
    # @return [String]
    def self.colorize_reference(uri)
      colorize('<', :red) <<
      colorize(uri.to_uri.to_s, :cyan) <<
      colorize('>', :red)
    end

    ##
    # @param  [String, #to_s] text
    # @param  [Symbol, #to_s] color
    # @return [String]
    def self.colorize(text, color)
      [(Color.const_get(color.to_s.upcase) rescue nil), text.to_s, Color::NOTHING].join('')
    end
  end # module Color
end; end # module Trith::Shell
