#!/usr/bin/env ruby -rubygems
require 'trith'

Trith::Machine.run do
  push("Hello, world!")
  print
end
