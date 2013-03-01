require 'yaml'
require 'pg'

class TestDatabaseGateway
  def self.connection
    @connection ||= Sequel.connect(ENV['DATABASE_URL'] || build_connection_string)
  end
  def self.delete_all
    TestDatabaseGateway.connection.from(:products).delete
  end

  private

  def self.build_connection_string
    configuration = load_all_configuration[ENV["BOOTY_ENV"] || "test"]
    "postgres://#{configuration['username']}:#{configuration['password']}@#{configuration['host']}/#{configuration['database']}"
  end

  def self.load_all_configuration
    YAML.load_file(File.join(File.dirname(__FILE__),'../../../build/db/configuration.yml'))
  end
end
