source ~/.bashrc
cd .

bundle install
cp ../db/configuration.yml.template ../db/configuration.yml
bundle exec rake ci --trace
