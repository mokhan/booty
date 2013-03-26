class SessionFactory
  def initialize(database_connection_factory)
    @connection_factory = database_connection_factory
  end
  def create
    Session.new(@connection_factory.create_connection)
  end
end
class Session
  def initialize(connection)
    @connection = connection
  end
  def run(&block)
    @connection.transaction(&block)
  end
  def connection
    @connection
  end
  def dispose
    @connection.disconnect
    @connection = nil
  end
end
