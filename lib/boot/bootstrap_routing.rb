require 'ioc'
require 'command_proxy'
Dir["#{File.dirname(__FILE__)}/../commands/**/*.rb"].each { |f| load(f) }

module Booty
  class BootstrapRouting
    def initialize(registry = IOC.resolve(:command_registry), container = IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      logger.debug("initializing routes")
      register(Assets::AssetCommand.new)
      register(proxy_to(Dashboard::IndexCommand))
      register(proxy_to(Products::IndexCommand))
      register(proxy_to(Products::IndexCommand))
      register(proxy_to(Products::NewCommand))
      register(proxy_to(Products::CreateCommand))
      register(proxy_to(Products::ShowCommand))
      register(@container.build(DefaultCommand))
    end

    private

    def register(command)
      @registry.register(command) if command
    end

    def proxy_to(command)
      CommandProxy.new(command, @container)
    end
  end
end
