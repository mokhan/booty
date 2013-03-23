Dir["#{File.dirname(__FILE__)}/../commands/**/*.rb"].each { |f| load(f) }

module Booty
  class BootstrapRouting
    def initialize(registry = IOC.resolve(:command_registry), container = IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      @registry.register(Assets::AssetCommand.new)
      @registry.register(proxy_to(Dashboard::IndexCommand))
      @registry.register(proxy_to(Products::IndexCommand))
      @registry.register(proxy_to(Products::NewCommand))
      @registry.register(proxy_to(Products::CreateCommand))
      @registry.register(proxy_to(Products::ShowCommand))
      @registry.register(proxy_to(Sessions::NewCommand))
      @registry.register(@container.build(DefaultCommand))
    end

    private

    def proxy_to(command)
      CommandProxy.new(command, @container)
    end
  end
end
