require 'routed_command'
require 'block_specification'

module Booty
  class CommandRegistry
    def initialize(commands = [])
      @commands = commands
    end

    def register(command)
      if block_given?
        register_route(command) { |request| yield(request) }
      else
        register_route(command) { |request| command.matches(request) }
      end
    end

    def register_route(command, &block)
      @commands.push(RoutedCommand.new(BlockSpecification.new(&block), command))
    end

    def command_for(route)
      @commands.find { |command| command.matches(route) }.command
    end
  end
end
