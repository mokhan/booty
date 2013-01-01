require 'ioc'
require 'default_command'
require 'index_command'

module Booty
  class BootstrapRouting
    def initialize(registry = Booty::IOC.resolve(:command_registry), container = Booty::IOC.resolve(:container))
      @registry = registry
      @container = container
    end

    def run
      @registry.register_route(Booty::Dashboard::IndexCommand.new(@container.resolve(:view_engine))) do |request|
        request["REQUEST_PATH"] == "/"
      end
      @registry.register_route(DefaultCommand.new(@container.resolve(:view_engine))) { |request| true }
    end
  end
end
