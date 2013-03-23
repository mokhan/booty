#!/bin/bash -x
echo 'run deployment'
bundle exec rake deploy --trace
