#!/usr/bin/env jruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
require 'rubygems'
require 'trith'

begin
  require 'rakefile' # http://github.com/bendiken/rakefile
rescue LoadError => e
end

CLASSPATH = ['.', 'src/java', ENV['CLASSPATH']].compact.join(':')

desc "Build all Java class files"
task :build do
  sh "javac -cp #{CLASSPATH} #{Dir.glob('src/java/**/*.java').join(' ')}"
end

task :default => :build
