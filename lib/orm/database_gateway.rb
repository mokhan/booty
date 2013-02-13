class DatabaseGateway
  def initialize(connection_factory)
    @connection_factory = connection_factory
  end
  def run(command_or_query)
    connection = @connection_factory.create_connection
    result = command_or_query.run(connection)
    connection.disconnect
    result
  end
end
