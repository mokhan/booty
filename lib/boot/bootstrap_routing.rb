Dir["#{File.dirname(__FILE__)}/../commands/**/*.rb"].each { |f| load(f) }

module Booty
  class BootstrapRouting
    def initialize(registry = IOC.resolve(:command_registry), container = IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      @registry.register(Assets::AssetCommand.new)
      @registry.register(proxy_to(Dashboard::IndexCommand)) do |request|
        Dashboard::IndexCommand.matches?(request)
      end
      @registry.register(proxy_to(Products::IndexCommand)) do |request|
        Products::IndexCommand.matches?(request)
      end
      @registry.register(proxy_to(Products::NewCommand)) do |request|
        Products::NewCommand.matches?(request)
      end
      @registry.register(proxy_to(Products::CreateCommand)) do |request|
        Products::CreateCommand.matches?(request)
      end
      @registry.register(proxy_to(Products::ShowCommand)) do |request|
        Products::ShowCommand.matches?(request)
      end
      @registry.register(proxy_to(Sessions::NewCommand)) do |request|
        Sessions::NewCommand.matches?(request)
      end
      @registry.register(@container.build(DefaultCommand))
    end

    private

    def proxy_to(command)
      CommandProxy.new(command, @container)
    end
  end
end
