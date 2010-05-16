#!/usr/bin/env ruby
require 'trith'

Trith::Machine.execute do
  push("Hello, world!")
  print
end
