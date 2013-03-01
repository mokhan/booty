
task :deploy do
  sh "git push heroku master"
  sh "heroku run rake db:migrate --app bootycall"
end
