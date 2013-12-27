require "rubygems"
require "rack"
Bundler.require(:default, (ENV["BOOTY_ENV"]|| "development").to_sym)

Dir["lib/**/*.rb"].each do |file| 
  $:.unshift(File.dirname(file)) unless $:.include?(File.dirname(file))
end

["infrastructure", "orm", "web"].each do |dir|
  Dir["lib/#{dir}/**/*.rb"].each do |file| 
    puts file
    require File.basename(file)
  end
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
