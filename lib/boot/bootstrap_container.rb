require 'product'
require 'user'

class BootstrapContainer
  def initialize(container = Spank::Container.new)
    @container = container
  end
  def run
    configuration = Humble::Configuration.new(DatabaseConfiguration.new.connection_string)
    configuration.add(UserMapping.new)
    configuration.add(ProductMapping.new)
    session_factory = configuration.build_session_factory

    @container.register(:command_registry) { Booty::RouteRegistry.new }.as_singleton
    @container.register(:front_controller) { @container.build(Booty::FrontController) }
    @container.register(:view_engine) do
      Booty::ViewEngine.new(:root_path => 'lib/commands', :master => 'master')
    end
    @container.register(:products_repository) do
      HumbleRepository.new(@container.resolve(:context).item_for(@container.resolve(:key)), Product)
    end
    @container.register(:users_repository) do
      HumbleRepository.new(@container.resolve(:context).item_for(@container.resolve(:key)), User)
    end
    @container.register(:unit_of_work_interceptor) do
      @container.build(UnitOfWorkInterceptor)
    end
    @container.register(:unit_of_work_factory) do
      @container.build(UnitOfWorkFactory)
    end
    @container.register(:context) do
      #this should be scoped to each request
      SimpleContext.new
    end.as_singleton
    @container.register(:session_factory) do
      session_factory
    end.as_singleton
    @container.register(:key) do
      Key.new("database.session")
    end.as_singleton
    Spank::IOC.bind_to(@container)
  end
end
