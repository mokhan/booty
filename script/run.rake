
namespace :run do
  task :development do 
    sh 'BOOTY_ENV=development rackup'
  end

  task :test do 
    sh 'BOOTY_ENV=test rackup'
  end
end
