require 'container'
require 'ioc'
require 'front_controller'
require 'command_registry'

container = Booty::Container.new
container.register(:command_registry) do
  Booty::CommandRegistry.new(container.resolve(:container))
end
container.register(:front_controller) do
  Booty::FrontController.new(container.resolve(:command_registry))
end

Booty::IOC.bind_to(container)
