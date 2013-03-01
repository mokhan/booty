require 'yaml'
require 'pg'

class DatabaseConfiguration
  def configure(connection)
    connection.connect(ENV['DATABASE_URL'] || build_connection_string)
  end

  private 

  def load_all_configuration
    YAML.load_file(File.join(File.dirname(__FILE__),'../../build/db/configuration.yml'))
  end

  def current_environment
    ENV["BOOTY_ENV"] || "test"
  end

  def build_connection_string
    configuration = load_all_configuration[current_environment]
    "postgres://#{configuration['username']}:#{configuration['password']}@#{configuration['host']}/#{configuration['database']}"
  end

end
