require 'default_command'

class CommandRegistry
  def command_for(request)
    DefaultCommand.new
  end
end
