require "rubygems"
require "rack"

Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
require 'front_controller'
require 'container'
require 'ioc'


container = Container.new
container.register(:command_registry) do
  CommandRegistry.new
end
container.register(:front_controller) do
  FrontController.new(container.resolve(:command_registry))
end

IOC.bind_to(container)

Rack::Handler::Mongrel.run IOC.resolve(:front_controller), :Port => 9292

