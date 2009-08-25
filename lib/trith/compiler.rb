module Trith
  class Compiler
    attr_accessor :code

    def self.compile(files, options = {}, &block)
      require 'sxp' unless defined?(::SXP)

      compiler = self.new(options)
      [files].flatten.each do |file|
        compiler << SXP.read_file(file)
      end
      compiler.compile!
    end

    def initialize(options = {}, &block)
      @options = options

      if block_given?
        block.call(self)
      end
    end

    def <<(exps)
      @code ||= []
      exps.respond_to?(:to_ary) ? @code += exps : @code << exps
    end

    def compile!
      raise NotImplementedError # TODO
    end
  end
end
