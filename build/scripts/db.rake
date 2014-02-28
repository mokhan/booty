
namespace :db do
  task :migrate do
    Database.new.migrate('development')
  end

  task 'migrate:test' do
    Database.new.migrate('test')
  end

  task :create do
    Database.new.create('development')
    Rake::Task['db:migrate'].invoke
  end

  task 'create:test' do
    Database.new.create('test')
    Rake::Task['db:migrate:test'].invoke
  end
end

class Database
  def create(environment)
    configuration = load_configuration_for(environment)
    database = configuration['database']
    username = configuration['username']
    host = configuration['host']
    #password = configuration['password']
    #command = "CREATE USER #{username} WITH password '#{password}'"
    #sh "psql -c '#{command}'"
    sh "psql -h #{host} -c 'CREATE DATABASE #{database} WITH OWNER #{username}'"
    sh "psql -h #{host} -c 'GRANT ALL PRIVILEGES ON DATABASE #{database} TO #{username}'"
  end

  def migrate(environment)
    connection_string = ENV["DATABASE_URL"] || create_connection_string_for(environment)
    sh "bundle exec sequel -m build/db/migrations -E #{connection_string}"
  end

  private

  def sh(command)
    Kernel::system(command)
  end

  def load_configuration_for(environment)
    all_configuration = YAML.load_file(File.join(File.dirname(__FILE__), '../db/configuration.yml'))
    all_configuration[ENV["BOOTY_ENV"] || environment]
  end

  def create_connection_string_for(environment)
    configuration = load_configuration_for(environment)
    "postgres://#{configuration['username']}:#{configuration['password']}@#{configuration['host']}/#{configuration['database']}"
  end
end

