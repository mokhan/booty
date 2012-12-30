require 'default_command'

module Booty
  class CommandRegistry
    def initialize(container)
      @container = container
    end
    def command_for(request)
      http_commands.find { |command| command.matches(request) } || DefaultCommand.new
    end
    private
    def http_commands
      @container.resolve_all(:http_command)
    end
  end
end
