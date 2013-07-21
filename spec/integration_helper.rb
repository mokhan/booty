require "spec_helper"

RSpec.configure do |config|
  config.before :all do
    connection_string = DatabaseConfiguration.new.connection_string
    @raw_connection = Sequel.connect(connection_string)
    @configuration = Humble::Configuration.new(connection_string)
    @session_factory = @configuration.build_session_factory
  end

  config.after :each do
    TestDatabaseGateway.delete_all
  end
end
