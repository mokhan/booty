
task :deploy do
  sh "git push heroku master"
  #sh "heroku run rake db:migrate --app bootycall"
end

namespace :deploy do
  task :log do
    sh "heroku logs --tail --app bootycall"
  end
end
