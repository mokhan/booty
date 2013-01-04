require "logger"

module Booty
  class Log
    def self.bind_to(log_factory)
      @@log_factory=log_factory
    end
    def self.for(target)
      @@log_factory.create_for(target)
    end
  end
  class ConsoleLogFactory
    def initialize(logger = Logger.new(STDOUT))
      @logger = logger
      @logger.level = Logger::DEBUG
    end
    def create_for(target)
      @logger
    end
  end
end
class Object
  def logger
    Booty::Log.for(self)
  end
end
