require 'yaml'

class DatabaseConfiguration
  def configure(connection)
    configuration = load_all_configuration[current_environment]
    connection.postgres(configuration["database"], :user => configuration["username"], :password => configuration["password"], :host => configuration['host'])
  end

  private 
  def load_all_configuration
    YAML.load_file(File.join(File.dirname(__FILE__),'../../../db/configuration.yml'))
  end
  def current_environment
    ENV["BOOTY_ENV"] || "test"
  end
end
