class DatabaseConnectionFactory
  def initialize(database_configuration, database_connection_provider)
    @database_configuration = database_configuration
    @database_connection_provider = database_connection_provider
  end
  def create_connection
    @database_configuration.configure(@database_connection_provider.provide)
  end
end
