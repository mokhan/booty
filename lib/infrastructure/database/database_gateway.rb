class DatabaseGateway
  def initialize(connection_factory)
    @connection_factory = connection_factory
  end
  def run(command_or_query)
    command_or_query.run(@connection_factory.create_connection)
  end
end
