
task :deploy do
  sh "git push heroku master"
  sh "rake run rake db:migrate --app rocky-coast-1223"
end
