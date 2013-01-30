class DatabaseGateway
  def initialize(connection_factory)
    @connection_factory = connection_factory
  end
  def run(query)
    query.run(@connection_factory.create_connection)
  end
end
