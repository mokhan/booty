require 'yaml'

task :default => :spec
task :spec => 'spec:all'
task :run => 'run:development'
task :ci => ['spec:unit', 'spec:integration']

namespace :run do
  task :development do 
    sh 'BOOTY_ENV=development rackup'
  end

  task :test do 
    sh 'BOOTY_ENV=test rackup'
  end
end

namespace :generate do
  task :migration, :title do |t, args|
    filename = "db/migrations/#{Time.now.strftime('%Y%m%d%H%M%S%L')}_#{args.title}.rb"
    puts "Creating new migration: #{filename}"
    open(filename, 'w') do |post|
      post.puts "Sequel.migration do"
      post.puts "  change do"
      post.puts "  end"
      post.puts "end"
    end
  end
end

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
    sh "psql -c 'CREATE DATABASE #{configuration['database']} WITH OWNER #{configuration['username']} '"
  end

  def migrate(environment)
    configuration = load_configuration_for(environment)
    connection_string = "postgres://#{configuration["host"]}/#{configuration["database"]}"
    sh "sequel -m db/migrations -E #{connection_string}"
  end

  private

  def sh(command)
    Kernel::system(command)
  end

  def load_configuration_for(environment)
    all_configuration = YAML.load_file(File.join(File.dirname(__FILE__),'db/configuration.yml'))
    all_configuration[ENV["BOOTY_ENV"] || environment]
  end
end

namespace :spec do
  task :all => [:unit, :integration, :acceptance]

  task :unit => 'db:migrate:test' do
    sh 'rspec spec/specs'
  end

  task :integration => 'db:migrate:test' do
    sh 'rspec spec/integration'
  end

  task :acceptance => 'db:migrate:test' do
    sh 'rspec spec/acceptance'
  end
end
