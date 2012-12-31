require 'container'
require 'ioc'
require 'front_controller'
require 'command_registry'
require 'view_engine'
require 'index_command'

class BootstrapContainer
  def initialize(container = Booty::Container.new)
    @container = container
  end
  def run
    @container.register(:command_registry) do
      Booty::CommandRegistry.new
    end
    @container.register(:front_controller) do
      Booty::FrontController.new(@container.resolve(:command_registry), @container.resolve(:view_engine))
    end
    @container.register(:view_engine) do
      Booty::ViewEngine.new(:root_path => 'lib/commands')
    end
    Booty::IOC.bind_to(@container)
  end
end
