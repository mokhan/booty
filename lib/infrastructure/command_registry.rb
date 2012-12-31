require 'default_command'
#require 'specification'

module Booty
  class CommandRegistry
    def initialize(container)
      @container = container
      @commands = []
    end

    def command_for(request)
      http_commands.find { |command| command.matches(request) } || DefaultCommand.new
    end

    def register_route(command, &block)
      @commands.push(RoutedCommand.new(BlockSpecification.new(&block), command))
    end

    def routed_command_for(route)
      @commands.find { |command| command.matches(route) }.command
    end

    private
    def http_commands
      @container.resolve_all(:http_command)
    end
  end

  class RoutedCommand
    attr_reader :command
    def initialize(specification, command)
      @specification = specification
      @command = command
    end
    def matches(item)
      @specification.matches(item)
    end
  end
end
