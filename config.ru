require "rubygems"
require "rack"
Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
require 'bootstrap_container'
require 'bootstrap_routing'

module Booty
  class Application
    def self.run
      BootstrapContainer.new.run
      BootstrapRouting.new.run
      Rack::Handler::Mongrel.run IOC.resolve(:front_controller), :Port => 9292
    end
  end
end

Booty::Application.run
