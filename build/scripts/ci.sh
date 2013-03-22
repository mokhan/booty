#!/bin/bash -x
echo 'loading bashrc'
source ~/.bashrc

echo 'loading gemset'
cd .

echo 'bundle install'
bundle install

echo 'cp db config'
cp build/db/configuration.yml.template build/db/configuration.yml

echo 'run tests'
bundle exec rake ci --trace
