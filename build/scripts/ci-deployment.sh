#!/bin/bash -x
echo 'loading bashrc'
source ~/.bashrc

echo 'loading gemset'
rvm use ruby-2.0.0-p247@booty --create

echo 'run deployment'
git checkout master
git pull
git push heroku master
heroku run rake db:migrate --app bootycall
#bundle exec rake deploy --trace
