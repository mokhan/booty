#!/bin/bash -x
echo 'loading bashrc'
source ~/.bashrc

echo 'loading gemset'
#cd .
rvm use ruby-2.0.0-p0@booty --create

echo 'run deployment'
bundle exec rake deploy --trace
