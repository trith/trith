#!/usr/bin/env jruby
require 'buildr'

# Specify Maven 2.0 remote repositories here:
repositories.remote << 'http://www.ibiblio.org/maven2/'

# Specify the project's directory layout here:
LAYOUT = Layout.new
LAYOUT[:source, :main, :java]       = 'src/java'
LAYOUT[:source, :spec, :java]       = 'spec/java'
LAYOUT[:source, :spec, :resources]  = 'spec/resources'
LAYOUT[:reports, :specs]            = 'spec/reports'
LAYOUT[:target, :main]              = 'pkg'
LAYOUT[:target]                     = 'pkg'

desc   "Trith"
define "trith", :layout => LAYOUT do
  project.version = File.read('VERSION').chomp
  project.group   = 'trith'
  manifest['Implementation-Vendor']  = 'Trith.org'
  manifest['Implementation-Version'] = project.version

  compile.options.target = '1.5'
  test.using :specs
  package :jar
end

RakeFileUtils.verbose_flag = false
