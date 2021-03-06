  class RoutedCommand
    attr_reader :command

    def initialize(specification, command)
      @specification = specification
      @command = command
    end

    def matches?(item)
      @specification.matches?(item)
    end

    def run(request)
      @command.run(request)
    end
  end
