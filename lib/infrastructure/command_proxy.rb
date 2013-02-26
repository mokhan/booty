  class CommandProxy
    def initialize(command, container)
      @command = command
      @container = container
    end
    def matches(route)
      @command.matches(route)
    end
    def run(request)
      @container.build(@command).run(request)
    end
    def instance_of?(type)
      @command == type
    end
  end
