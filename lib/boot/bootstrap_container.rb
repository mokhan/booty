require 'container'
require 'ioc'
require 'front_controller'
require 'command_registry'
require 'view_engine'
require 'index_command'

container = Booty::Container.new
container.register(:command_registry) do
  Booty::CommandRegistry.new(container.resolve(:container))
end
container.register(:front_controller) do
  Booty::FrontController.new(container.resolve(:command_registry))
end
container.register(:view_engine) do
  Booty::ViewEngine.new(:root_path => 'lib/views')
end
container.register(:http_command) do
  Booty::Dashboard::IndexCommand.new(container.resolve(:view_engine))
end

Booty::IOC.bind_to(container)
