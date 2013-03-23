require 'reload_file_strategy'

class CommandProxy
  def initialize(command, container, load_strategy = ReloadFileStrategy.new)
    @command = command
    @container = container
    @load_strategy = load_strategy
  end
  def matches?(route)
    @command.matches?(route)
  end
  def run(request)
    @load_strategy.reload(@command)
    command.run(request)
  end
  def instance_of?(type)
    @command == type
  end
  def command
   @container.build(@command)
  end
end
