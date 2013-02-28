require 'product'

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
    @container.register(:products_repository) do
      Repository.new(:products, @container.resolve(:database_gateway), DataMapper.new(Product))
    end
    @container.register(:database_gateway) do
      DatabaseGateway.new(@container.resolve(:database_connection_factory))
    end
    @container.register(:database_connection_factory) do
      DatabaseConnectionFactory.new(@container.resolve(:database_configuration), @container.resolve(:database_connection_provider))
    end
    @container.register(:database_configuration) do
      DatabaseConfiguration.new
    end
    @container.register(:database_connection_provider) do
      SequelConnectionProvider.new
    end
    Booty::IOC.bind_to(@container)
  end
end
