Dir["#{File.dirname(__FILE__)}/../commands/**/*.rb"].each { |f| load(f) }

module Booty
  class BootstrapRouting
    def initialize(registry = Spank::IOC.resolve(:command_registry), container = Spank::IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      @registry.register(Assets::AssetCommand.new)
      #@registry.register(route_to(Dashboard::IndexCommand, [@container.resolve(:current_user_interceptor)]))
      @registry.register(route_to(Dashboard::IndexCommand))
      @registry.register(route_to(Products::IndexCommand))
      @registry.register(route_to(Products::NewCommand))
      @registry.register(route_to(Products::CreateCommand))
      @registry.register(route_to(Products::ShowCommand))
      @registry.register(route_to(Sessions::NewCommand))
      @registry.register(route_to(Sessions::OAuth::NewCommand))
      @registry.register(route_to(Sessions::CreateCommand))
      @registry.register(route_to(Registrations::CreateCommand))
      @registry.register(@container.build(DefaultCommand))
    end

    private

    def route_to(command, interceptors = [])
      proxy = Spank::Proxy.new(Route.new(command, @container))
      proxy.add_interceptor(:run, @container.resolve(:unit_of_work_interceptor))
      interceptors.each { |x| proxy.add_interceptor(:run, x) }
      proxy
    end
  end
end
