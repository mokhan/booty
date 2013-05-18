require "rubygems"
require "rack"
Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
["infrastructure", "orm", "web"].each do |dir|
  Dir["#{File.dirname(__FILE__)}/lib/#{dir}/**/*.rb"].each { |f| require(f) }
end
require 'bootstrap_container'
require 'routes'
require 'log'

module Booty
  class Application
    def self.run
      Log.bind_to(ConsoleLogFactory.new)
      BootstrapContainer.new.run
      BootstrapRouting.new.run
      logger.debug("starting up http://localhost:9292")

      Spank::IOC.resolve(:front_controller)
    end
  end
end

run Booty::Application.run
