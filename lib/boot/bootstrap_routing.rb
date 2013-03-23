Dir["#{File.dirname(__FILE__)}/../commands/**/*.rb"].each { |f| load(f) }

module Booty
  class BootstrapRouting
    def initialize(registry = IOC.resolve(:command_registry), container = IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      @registry.register(Assets::AssetCommand.new)
      @registry.register(route_to(Dashboard::IndexCommand))
      @registry.register(route_to(Products::IndexCommand))
      @registry.register(route_to(Products::NewCommand))
      @registry.register(route_to(Products::CreateCommand))
      @registry.register(route_to(Products::ShowCommand))
      @registry.register(route_to(Sessions::NewCommand))
      @registry.register(@container.build(DefaultCommand))
    end

    private

    def route_to(command)
      Route.new(command, @container)
      #proxy = Proxy.new(Route.new(command, @container))
      #proxy.add_interceptor(:run, UnitOfWorkInterceptor.new(UnitOfWorkFactory.new(SimpleContext.new,nil,Key.new("database.session")))
    end
  end
end
