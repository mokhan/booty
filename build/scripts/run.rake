
namespace :run do
  task :development do 
    sh 'BOOTY_ENV=development bundle exec rackup config.ru -p 9292 -s mongrel'
  end

  task :test do 
    sh 'BOOTY_ENV=test bundle exec rackup config.ru -p 9292 -s mongrel'
  end
end
