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
    logger.debug("initialize container")
    @container.register(:command_registry) { Booty::CommandRegistry.new }.as_singleton
    @container.register(:front_controller) { @container.build(Booty::FrontController) }
    @container.register(:view_engine) do
      Booty::ViewEngine.new(:root_path => 'lib/commands', :master => 'master.html.erb', :model => OpenStruct.new)
    end
    Booty::IOC.bind_to(@container)
  end
end
