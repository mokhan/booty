#!/bin/bash -x
echo 'loading bashrc'
source ~/.bashrc

echo 'loading gemset'
rvm use ruby-2.0.0-p247@booty --create

echo 'bundle install'
bundle install

echo 'run tests'
export CI=true
bundle exec rake spec:integration --trace
