module Booty
  class FrontController
    def initialize(command_registry)
      @command_registry = command_registry
    end
    def call(env)
      @command_registry.command_for(env).run_against(env)
    end
  end
end
