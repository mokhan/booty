require 'yaml'

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
    all_configuration = YAML.load_file(File.join(File.dirname(__FILE__),'db/configuration.yml'))
    configuration = all_configuration[ENV["BOOTY_ENV"] || "test"]
    sh "sequel -m db/migrations -E postgres://#{configuration["host"]}/#{configuration["database"]}"
  end
  task :create => 'db:migrate'
end

namespace :spec do
  task :all => [:unit, :integration, :acceptance]

  task :unit => 'db:migrate' do
    sh 'rspec spec/specs'
  end
  task :integration => 'db:migrate' do
    sh 'rspec spec/integration'
  end
  task :acceptance => 'db:migrate' do
    sh 'rackup &'
    sh 'rspec spec/acceptance'
    sh 'killall rackup'
  end
end
task :spec => 'spec:all'
task :default => :spec
