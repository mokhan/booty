require 'ioc'
require 'default_command'
require 'index_command'
require "asset_command"

module Booty
  class BootstrapRouting
    def initialize(registry = IOC.resolve(:command_registry), container = IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      logger.debug("initializing routes")
      register(Assets::AssetCommand.new)
      register(Dashboard::IndexCommand.new(@container.resolve(:view_engine)))
      register(DefaultCommand.new(@container.resolve(:view_engine))) { |request| true }
    end

    private

    def register(command)
      if block_given?
        @registry.register_route(command) { |request| yield(request) }
      else
        @registry.register_route(command) { |request| command.matches(request) }
      end
    end
  end
end
