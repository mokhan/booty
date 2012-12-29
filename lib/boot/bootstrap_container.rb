require 'container'
require 'ioc'
require 'front_controller'
require 'command_registry'

container = Container.new
container.register(:command_registry) do
  CommandRegistry.new(container.resolve(:container))
end
container.register(:front_controller) do
  FrontController.new(container.resolve(:command_registry))
end

IOC.bind_to(container)
