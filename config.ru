require "rubygems"
require "rack"

Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
require 'front_controller'

class IOC
  def self.bind_to(container)
    @@container = container
  end
  def self.resolve(symbol)
    @@container.resolve(symbol)
  end
end
class Container
  def initialize
    @items = {}
    register(:container) { self }
  end
  def register(symbol, &block)
    @items[symbol] = block
  end
  def resolve(symbol)
    p "resolving #{symbol} at #{Time.now}"
    @items[symbol].call(self)
  end
end

container = Container.new
container.register(:command_registry) do
  CommandRegistry.new
end
container.register(:front_controller) do
  FrontController.new(container.resolve(:command_registry))
end

IOC.bind_to(container)

Rack::Handler::Mongrel.run IOC.resolve(:front_controller), :Port => 9292

