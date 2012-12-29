require "rubygems"
require "rack"
Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
require 'bootstrap_container'

Rack::Handler::Mongrel.run IOC.resolve(:front_controller), :Port => 9292
