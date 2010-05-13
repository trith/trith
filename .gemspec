#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

GEMSPEC = Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'trith'
  gem.homepage           = 'http://trith.org/'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.summary            = 'An experimental programming language.'
  gem.description        = gem.summary
  gem.rubyforge_project  = 'trith'

  gem.authors            = ['Arto Bendiken']
  gem.email              = 'arto.bendiken@gmail.com'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS README UNLICENSE VERSION)
  gem.files             += Dir.glob('etc/*.{ttl,nt}')
  gem.files             += Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w(3th 3sh 3vm 3cc)
  gem.default_executable = gem.executables.first
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 1.9.1'
  gem.requirements               = ['JRuby (>= 1.4.0)']
  gem.add_development_dependency 'buildr' , '>= 1.3.5'
  gem.add_development_dependency 'rspec',   '>= 1.3.0'
  gem.add_development_dependency 'yard' ,   '>= 0.5.4'
  gem.add_runtime_dependency     'rdf',     '>= 0.1.9'
  gem.add_runtime_dependency     'sxp',     '>= 0.0.1'
  gem.post_install_message       = nil
end
