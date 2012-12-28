require 'command_registry'

class FrontController
  def initialize(command_registry=CommandRegistry.new)
    @command_registry = command_registry
  end
  def call(env)
    @command_registry.command_for(env).run_against(env)
  end
end
