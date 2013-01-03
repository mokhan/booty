require 'ioc'
require 'default_command'
require 'index_command'
require "asset_command"

module Booty
  class BootstrapRouting
    def initialize(registry = Booty::IOC.resolve(:command_registry), container = Booty::IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      register(Booty::Assets::AssetCommand.new)
      register(Booty::Dashboard::IndexCommand.new(@container.resolve(:view_engine)))
      register(DefaultCommand.new(@container.resolve(:view_engine))) { |request| true }
    end

    private

    def register(command)
      if( block_given? )
        @registry.register_route(command) { |request| yield(request) }
      else
        @registry.register_route(command) { |request| command.matches(request) }
      end
    end
  end
end
