require 'product'

class BootstrapContainer
  def initialize(container = Spank::Container.new)
    @container = container
  end
  def run
    @container.register(:command_registry) { Booty::RouteRegistry.new }.as_singleton
    @container.register(:front_controller) { @container.build(Booty::FrontController) }
    @container.register(:view_engine) do
      Booty::ViewEngine.new(:root_path => 'lib/commands', :master => 'master')
    end
    @container.register(:products_repository) do
      Repository.new(:products, @container.resolve(:database_gateway), DataMapper.new(Product))
    end
    @container.register(:users_repository) do
      Repository.new(:users, @container.resolve(:database_gateway), DataMapper.new(User))
    end
    @container.register(:database_gateway) do
      @container.build(DatabaseGateway)
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
      @container.build(SessionFactory)
    end
    @container.register(:key) do
      Key.new("database.session")
    end
    Spank::IOC.bind_to(@container)
  end
end
