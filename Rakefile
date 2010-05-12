#!/usr/bin/env jruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
require 'rubygems'
require 'trith'

begin
  require 'rakefile' # http://github.com/bendiken/rakefile
rescue LoadError => e
end

CLASSPATH = ['.', 'pkg/classes', ENV['CLASSPATH']].compact.join(':')

desc "Delete all Java class files"
task :clean do
  sh "find pkg/classes -name '*.class' | xargs rm"
end

desc "Compile all Java source files"
task :build do
  sh "mkdir -p pkg/classes"
  sh "javac -cp #{CLASSPATH} -d pkg/classes #{Dir.glob('src/java/**/*.java').join(' ')}"
end

task :default => :build
