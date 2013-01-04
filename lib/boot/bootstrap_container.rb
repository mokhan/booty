require 'container'
require 'ioc'
require 'front_controller'
require 'command_registry'
require 'view_engine'

class BootstrapContainer
  def initialize(container = Booty::Container.new)
    @container = container
  end
  def run
    Booty::Log.for(self).debug("initialize container")
    @container.register(:command_registry) { Booty::CommandRegistry.new }.as_singleton
    @container.register(:front_controller) do
      Booty::FrontController.new(@container.resolve(:command_registry), @container.resolve(:view_engine))
    end
    @container.register(:view_engine) do
      Booty::ViewEngine.new(:root_path => 'lib/commands', :master => 'master.html.erb', :model => OpenStruct.new)
    end
    Booty::IOC.bind_to(@container)
  end
end
