require 'default_command'

module Booty
  class CommandRegistry
    def initialize
      @commands = []
      register_route(DefaultCommand.new) { |request| true }
    end

    def register_route(command, &block)
      @commands.unshift(RoutedCommand.new(BlockSpecification.new(&block), command))
    end

    def command_for(route)
      @commands.find { |command| command.matches(route) }.command
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
